module MIME

  #
  # General purpose MIME errors.
  #
  class Error < StandardError ; end

  #
  # Undetectable MIME content type error.
  #
  class UnknownContentError < Error ; end

  #
  # Abstract class object initialization error. Many classes in the MIME
  # library are abstract and will raise this error.
  #
  class AbstractClassError < Error

    #
    # A helper method for detecting the intialization of an object in an
    # abstract class. +myself+ must always be *self* and +klass+ is the
    # abstract class object.
    #
    def self.no_instantiation myself, klass
      if myself.class == klass
        raise AbstractClassError.new('cannot construct abstract class')
      end
    end

  end

end
