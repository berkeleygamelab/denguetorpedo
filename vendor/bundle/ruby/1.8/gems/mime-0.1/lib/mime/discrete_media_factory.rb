module MIME

  #
  # Class object used only for initializing derived DiscreteMediaType objects.
  #
  class DiscreteMediaFactory

    class << self

      include ContentTypes

      #
      # Creates a corresponding DiscreteMediaType subclass object for the given
      # +file+ based on +file+'s filename extension. +file+ can be a file path
      # or File object.
      #
      # +content_type+ can be specified in order to override the auto detected
      # content type. If the +content_type+ cannot be detected, an
      # UnknownContentError exception will be raised.
      #
      # Creates and sets the singleton method +path+ on the created object. The
      # +path+ method is utilized by other methods in the MIME library,
      # therefore, eliminating redundant and explicit filename assignments.
      #
      # ==== Comparison Example
      #
      #  entity1 = open('/tmp/file1.txt')
      #  entity2 = DiscreteMediaFactory.create('/tmp/file2.txt')
      #
      #  mixed_msg = Multipart::Mixed.new
      #  mixed_msg.attach_entity(entity1.read, entity.path)
      #  mixed_msg.attach_entity(entity2) # no path needed
      #
      def create file, content_type = nil
        if file.is_a? File
          cntnt = file.read
          ctype = content_type || file_type(file.path)
          fname = file.path
        else
          cntnt = IO.read(file)
          ctype = content_type || file_type(file)
          fname = file
        end

        raise UnknownContentError  unless ctype

        media_obj = 
          case ctype.match(/^(\w+)\//)[1]
          when 'application'; ApplicationMedia.new(cntnt, ctype)
          when 'audio'      ; AudioMedia.new(cntnt, ctype)
          when 'image'      ; ImageMedia.new(cntnt, ctype)
          when 'text'       ; TextMedia.new(cntnt, ctype)
          when 'video'      ; VideoMedia.new(cntnt, ctype)
          end

        class << media_obj;  attr_accessor :path  end
        media_obj.path = fname
        media_obj
      end

    end

    def initialize
      AbstractClassError.no_instantiation self, DiscreteMediaFactory
    end

  end

end
