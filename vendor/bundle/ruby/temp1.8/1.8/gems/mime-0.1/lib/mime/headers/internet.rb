module MIME
  module Headers

    #
    # The RFC 2822 Internet message header fields.
    #
    module Internet

      attr_reader :date, :from, :to
      attr_reader :cc, :bcc, :reply_to, :message_id
      attr_reader :comments, :keywords, :subject


      #
      # Required Headers
      #

      def date= date
        @date = date
        headers.add('Date', @date)
      end

      def from= list
        @from = stringify_email_list(list)
        headers.add('From', @from)
      end

      def to= list
        @to = stringify_email_list(list)
        headers.add('To', @to)
      end


      #
      # Optional Headers
      #

      def cc= list
        @cc = stringify_email_list(list)
        headers.add('Cc', @cc)
      end

      def bcc= list
        @bcc = stringify_email_list(list)
        headers.add('Bcc', @bcc)
      end

      def reply_to= list
        @reply_to = stringify_email_list(list)
        headers.add('Reply-To', @reply_to)
      end

      #
      # The message +id+ must contain an embedded "@" symbol. An example +id+
      # might be <em>some-unique-id@domain.com</em>.
      #
      def message_id= id
        @message_id = "<#{id}>"
        headers.add('Message-ID', @message_id)
      end

      def comments= comments
        @comments = comments
        headers.add('Comments', @comments)
      end

      def keywords= keywords
        @keywords = keywords
        headers.add('Keywords', @keywords)
      end

      def subject= subject
        @subject = subject
        headers.add('Subject', @subject)
      end


      private

      #
      # +list+ may be a single email address or a Hash of _email_ => _name_
      # pairs. Set _name_ to nil when it is unknown.
      #
      def stringify_email_list list
        list.map {|email, name| name ? "#{name} <#{email}>" : email}.join(', ')
      end

    end
  end
end
