module ResearchAssistant
  module ReviewEngine
    class Refiner

      PROMPT = <<~PROMPT
        Refine the Article %<article>s 
        ---
        based on the review: %<review>s
      PROMPT

      attr_reader :refiner_client

      def initialize(refiner_client)
        @refiner_client = refiner_client
      end

      def refine_article(article, review)
        prompt = format(PROMPT, article: article, review: review)
        refiner_client.refine_article(prompt)
      end
    end
  end
end