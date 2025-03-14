module ResearchAssistant
  module ReviewEngine
    class Reviewer
      attr_reader :review_client

      def initialize(review_client)
        @review_client = review_client
      end

      def review(article)
        review_client.review(article)
      end
    end
  end
end