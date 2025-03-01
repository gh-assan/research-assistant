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

      attr_reader :api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def should_terminate?(knowledge)
        objectives_met?(knowledge) || min_score_met?(knowledge) || max_iterations_reached?(knowledge)
      end

      private

      def max_iterations_reached?(knowledge)
        knowledge.iteration >= knowledge.max_iterations
      end

      def min_score_met?(knowledge)
        score(knowledge.user_intent, knowledge.article) >= 90 && knowledge.iteration > 1
      end

      def score(topic, text)
        prompt = " Please evaluate the given text and assign a score from 0 to 100 based on how well it meets the user's objectives. Consider factors such as relevance, completeness, accuracy, and clarity.
                   {
                    rank: value,
                    reasons: A concise explanation of why the given score was assigned, highlighting strengths and areas for improvement.
                   }
                  Here is the User Request: #{topic}
                  text: #{text}
                  "
        response = api_client.query(prompt)
        parse_response = parse_response(response)

        rank = parse_response['rank']
        reasons = parse_response['reasons']
        pp  "score of the current iteration article is #{rank} and the reasons are #{reasons}"

        if  rank.nil?
          return 1
        end
        rank
      end

      def parse_response(response)
        json_api_client.query(response, RANK_SCHEMA)
      end

      def objectives_met?(knowledge)

        if knowledge.knowledge_gaps.nil? || knowledge.iteration < 2
          return false
        end

        knowledge.knowledge_gaps.empty?
      end
    end
  end
end