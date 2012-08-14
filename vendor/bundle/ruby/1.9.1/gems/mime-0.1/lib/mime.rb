#
# = Construct Multipurpose Internet Mail Extensions (MIME) messages.
#
# ---
#
# RFCs referenced during the implementation of this library:
#
# * RFC-2822 Internet Message Format (obsoletes 822)
# * RFC-2045 MIME Part 1: Format of Internet Message Bodies
# * RFC-2046 MIME Part 2: Media Types
# * RFC-2047 MIME Part 3: Message Header Extensions for Non-ASCII Text
# * RFC-2048 MIME Part 4: Registration Procedures
# * RFC-2049 MIME Part 5: Conformance Criteria and Examples
#
# ---
#
# See SOAP::MIMEMessage for other implementation ideas.
#
module MIME

  VERSION = '0.1'

end

require 'mime/content_types'
require 'mime/error'
require 'mime/header_container'
require 'mime/media_type'
require 'mime/discrete_media_type'
require 'mime/composite_media_type'
require 'mime/message'
require 'mime/discrete_media_factory'
