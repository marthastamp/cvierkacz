class ShortMessagesQuery

    def initialize(filters)
        @filters = filters
        @messages = Message.all
      end
    
      def call
        return @messages unless @filters
        filter_by_chars_count
        @messages
      end
    
      private
    
      def filter_by_chars_count
        @messages = @messages.where("content < ?", 20)
      end

end