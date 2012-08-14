module MIME

  #
  # Handles MIME content type detection using file name extension.
  #
  # === See Also
  #
  # * http://w3schools.com/media/media_mimeref.asp for more content types
  # * rubygem MIME::Types for extensive content type lookup
  #
  module ContentTypes

    #
    # Content types are in the form of <em>media-type/sub-type</em>. Each
    # content type has one or more file extentions associated with it.
    #
    # The content types below are listed in alphabetical order and the
    # extention arrays are in order of preference.
    #
    # The following content types were stolen from the NGiNX webserver. NGiNX
    # is great server, check it out at http://nginx.net.
    #
    CONTENT_TYPES = {
      'application/atom+xml'            => %w(atom),
      'application/java-archive'        => %w(jar war ear),
      'application/mac-binhex40'        => %w(hqx),
      'application/msword'              => %w(doc),
      'application/octet-stream'        => %w(bin exe dll deb dmg eot iso img msi msp msm),
      'application/pdf'                 => %w(pdf),
      'application/postscript'          => %w(ps eps ai),
      'application/rtf'                 => %w(rtf),
      'application/vnd.ms-excel'        => %w(xls),
      'application/vnd.ms-powerpoint'   => %w(ppt),
      'application/vnd.wap.wmlc'        => %w(wmlc),
      'application/vnd.wap.xhtml+xml'   => %w(xhtml),
      'application/x-cocoa'             => %w(cco),
      'application/x-java-archive-diff' => %w(jardiff),
      'application/x-java-jnlp-file'    => %w(jnlp),
      'application/x-javascript'        => %w(js),
      'application/x-makeself'          => %w(run),
      'application/x-perl'              => %w(pl pm),
      'application/x-pilot'             => %w(prc pdb),
      'application/x-rar-compressed'    => %w(rar),
      'application/x-redhat-package-manager' => %w(rpm),
      'application/x-sea'               => %w(sea),
      'application/x-shockwave-flash'   => %w(swf),
      'application/x-stuffit'           => %w(sit),
      'application/x-tcl'               => %w(tcl tk),
      'application/x-x509-ca-cert'      => %w(crt pem der),
      'application/x-xpinstall'         => %w(xpi),
      'application/zip'                 => %w(zip),

      'audio/midi'                      => %w(mid midi kar),
      'audio/mpeg'                      => %w(mp3),
      'audio/x-realaudio'               => %w(ra),

      'image/gif'                       => %w(gif),
      'image/jpeg'                      => %w(jpg jpeg),
      'image/png'                       => %w(png),
      'image/tiff'                      => %w(tif tiff),
      'image/vnd.wap.wbmp'              => %w(wbmp),
      'image/x-icon'                    => %w(ico),
      'image/x-jng'                     => %w(jng),
      'image/x-ms-bmp'                  => %w(bmp),
      'image/svg+xml'                   => %w(svg),

      'text/css'                        => %w(css),
      'text/html'                       => %w(html htm shtml),
      'text/mathml'                     => %w(mml),
      'text/plain'                      => %w(txt),
      'text/x-component'                => %w(htc),
      'text/xml'                        => %w(xml rss),

      'video/3gpp'                      => %w(3gpp 3gp),
      'video/mpeg'                      => %w(mpeg mpg),
      'video/quicktime'                 => %w(mov),
      'video/x-flv'                     => %w(flv),
      'video/x-mng'                     => %w(mng),
      'video/x-ms-asf'                  => %w(asx asf),
      'video/x-ms-wmv'                  => %w(wmv),
      'video/x-msvideo'                 => %w(avi)
    }

    #
    # Return the MIME content type of the +file+ path or object.
    #
    def file_type file
      filename = file.respond_to?(:path) ? file.path : file
      extension = File.extname(filename)[1..-1] # array index removes period
      typ_exts = CONTENT_TYPES.find {|type, extentions| extentions.include? extension}
      typ_exts ? typ_exts.first : typ_exts      # returns +type+ from above or nil
    end

  end

end
