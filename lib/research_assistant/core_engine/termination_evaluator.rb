module ResearchAssistant
  module CoreEngine
    class TerminationEvaluator

      RANK_SCHEMA = <<~PROMPT
        Please analyze the text and assign a rank coming from the text . 
        Provide the response in the following format:
        {
          "rank": value, 
          "reasons": "A concise explanation of why the given score was assigned, highlighting strengths and areas for improvement."
        }
      PROMPT

      SCORE_PROMPT_TEMPLATE = <<~PROMPT
        Please evaluate the given text and assign a score from 0 to 100 based on how well it meets the user's objectives. Consider factors such as relevance, completeness, accuracy, and clarity.
        {
          rank: value,
          reasons: A concise explanation of why the given score was assigned, highlighting strengths and areas for improvement.
        }
        Here is the User Request: %<topic>s
        text: %<text>s
      PROMPT

      attr_reader :reasoning_api_client, :json_api_client

      def initialize(reasoning_api_client, json_api_client)
        @reasoning_api_client = reasoning_api_client
        @json_api_client = json_api_client
      end

      def should_terminate?(knowledge)
        max_iterations_reached?(knowledge) || min_score_met?(knowledge)
      end

      private

      def max_iterations_reached?(knowledge)
        knowledge.iteration >= knowledge.max_iterations
      end

      def min_score_met?(knowledge)
        score(knowledge.user_intent, knowledge.article) >= 95 && knowledge.iteration > 1
      end

      def score(topic, text)
        prompt = format(SCORE_PROMPT_TEMPLATE, topic: topic, text: text)
        response = reasoning_api_client.query(prompt)
        parse_response = parse_response(response)

        rank = parse_response['rank']
        reasons = parse_response['reasons']
        pp "score of the current iteration article is #{rank} and the reasons are #{reasons}"

        if rank.nil?
          return 1
        end
        rank
      end

      def parse_response(response)
        json_api_client.query(response, RANK_SCHEMA)
      end

      def objectives_met?(knowledge)
        return false
      end
    end
  end
end