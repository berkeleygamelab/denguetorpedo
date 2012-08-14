require 'mime'
require 'test/unit'

class MIMETest < Test::Unit::TestCase

  include MIME

  def test_make_top_level_rfc2822_message
    data = "\r\nmessage body"
    rfc2822_msg = Message.new
    rfc2822_msg.body = data
    expected_msg =
      "Message-ID: <993708956@989739608>\r\n"\
      "Date: Wed, 24 Oct 2008 15:45:31 -0700\r\n"\
      "MIME-Version: 1.0 (Ruby MIME v0.1)\r\n"\
      "\r\nmessage body\r\n"

    assert_equal_mime_message expected_msg, rfc2822_msg.to_s
  end

  def test_make_audio_message
    audio = '0110000101110101011001000110100101101111'
    audio_media = AudioMedia.new(audio, 'audio/midi')
    audio_media.content_transfer_encoding = 'binary'

    mime_msg = Message.new(audio_media).to_s
    expected_mime_msg = IO.read(sd('/audio.msg'))

    assert_equal_mime_message expected_mime_msg, mime_msg
  end

  def test_make_application_message
    application = '011000100110100101101110011000010111001001111001'
    application_media = ApplicationMedia.new(application)
    application_media.content_transfer_encoding = 'binary'

    mime_msg = Message.new(application_media).to_s
    expected_mime_msg = IO.read(sd('/application.msg'))

    assert_equal_mime_message expected_mime_msg, mime_msg
  end

  def test_make_image_message
    image = IO.read(sd('/image.jpg'))
    image_media = ImageMedia.new(image)
    image_media.content_type = 'image/jpeg'
    image_media.content_transfer_encoding = 'binary'

    mime_msg = Message.new(image_media).to_s
    expected_mime_msg = IO.read(sd('/image.msg'))

    assert_equal_mime_message expected_mime_msg, mime_msg
  end

  def test_make_text_message
    text = 'a plain text message'
    mime_msg = Message.new(TextMedia.new(text)).to_s
    expected_mime_msg = IO.read(sd('/text.msg'))

    assert_equal_mime_message expected_mime_msg, mime_msg
  end

  def test_make_video_message
    video = '0111011001101001011001000110010101101111'
    video_media = VideoMedia.new(video)
    video_media.content_type = 'video/mpeg'
    video_media.content_transfer_encoding = 'binary'

    mime_msg = Message.new(video_media).to_s
    expected_mime_msg = IO.read(sd('/video.msg'))

    assert_equal_mime_message expected_mime_msg, mime_msg
  end

  def test_no_instantiation_of_abstract_classes
    e = AbstractClassError
    assert_raise(e) {MediaType.new(nil, nil)}
    assert_raise(e) {DiscreteMediaType.new(nil)}
    assert_raise(e) {CompositeMediaType.new(nil)}
    assert_raise(e) {MultipartMedia.new(nil)}
  end

  def test_multipart_form_data_with_text_entities
    t1 = TextMedia.new('this is t1')
    t2 = TextMedia.new('this is t2', 'text/enhanced')
    t3 = open(sd('/index.html')) {|f| TextMedia.new(f.read, 'text/html')}
    t4 = open(sd('/data.xml')) {|f| TextMedia.new(f.read, 'text/xml')}

    form_data = MultipartMedia::FormData.new
    form_data.add_entity t1, 'txt1'
    form_data.add_entity t2, 'txt2'
    form_data.add_entity t3, 'txt3'
    form_data.add_entity t3, 'txt3'

    expected = IO.read(sd('/multipart_form_data_text.msg'))

    assert_equal_mime_message expected, form_data.to_s
  end

  def test_multipart_form_data_with_file_entities
    img1 = sd('/image.jpg')
    img2 = sd('/ruby.png')
    f1 = open(img1) {|f| ImageMedia.new(f.read, 'image/jpeg')}
    f2 = open(img2) {|f| ImageMedia.new(f.read, 'image/png')}

    f1.content_transfer_encoding = 'binary'
    f2.content_transfer_encoding = 'binary'

    form_data = MultipartMedia::FormData.new
    form_data.add_entity f1, 'file1', img1
    form_data.add_entity f2, 'file2', img2

    expected = IO.read(sd('/multipart_form_data_file.msg'))

    assert_equal_mime_message expected, form_data.to_s
  end

  def test_multipart_form_data_with_file_and_text_entities
    t1 = TextMedia.new('this is t1')
    t2 = TextMedia.new('this is t2', 'text/enhanced')

    img1 = sd('/image.jpg')
    f1 = open(img1) {|f| ImageMedia.new(f.read, 'image/jpeg')}
    f1.content_transfer_encoding = 'binary'
  
    form_data = MultipartMedia::FormData.new
    form_data.add_entity t1, 'txt1'
    form_data.add_entity t2, 'txt2'
    form_data.add_entity f1, 'img1', img1

    expected = IO.read(sd('/multipart_form_data_file_and_text.msg'))

    assert_equal_mime_message expected, form_data.to_s
  end

  def test_construction_of_plain_text_email_message
    email_msg = Message.new
    email_msg.to = {
      'person1@domain.com' => 'Harry',
      'person2@domain.com' => nil,
      'person3@domain.com' => 'Mary'
    }
    email_msg.cc = {'Head Honcho' => 'bossman@domain.com'}
    email_msg.from = 'person4@domain.com'
    email_msg.subject = 'This is an important email'
#TODO - what do we do about this body thing???????? raw_body= and body= 
    email_msg.body = "\r\nThis is the all important email body"
    #email_msg.body = TextMedia.new("This is the all important email body")

    expected = IO.read(sd('/plain_text_email.msg'))

    assert_equal_mime_message expected, email_msg.to_s
  end

  def test_content_type_detection
    (o = Object.new).extend(ContentTypes)

    # test using file path
    assert_equal 'application/pdf', o.file_type('book.pdf')
    assert_equal 'audio/mpeg', o.file_type('/tmp/song.mp3')
    assert_equal 'text/css', o.file_type('/tmp/main.css')
    assert_equal 'video/quicktime', o.file_type('mini.mov')
    assert_equal 'application/octet-stream', o.file_type('dsk.iso')
    assert_equal nil, o.file_type('file.yyy')

    # test using file object
    img_file = sd('/ruby.png')
    img_type = open(img_file) {|f| o.file_type(f)}
    assert_equal 'image/png', img_type
    assert_not_equal 'image/jpeg', img_type
  end

  def test_object_instantiation_using_discrete_media_factory
    application_file = sd('/book.pdf')
    audio_file = sd('/song.mp3')
    text_file = sd('/data.xml')
    video_file = sd('/mini.mov')
    image_file = sd('/image.jpg')
    unknown_file = sd('/unknown.yyy')

    dmf = DiscreteMediaFactory

    # test using file path
    assert_kind_of ApplicationMedia, dmf.create(application_file)
    assert_kind_of AudioMedia, dmf.create(audio_file)
    assert_kind_of TextMedia, dmf.create(text_file)
    assert_kind_of VideoMedia, dmf.create(video_file)

    # test using file object
    open(image_file) do |image_file_obj|
      assert_kind_of ImageMedia, dmf.create(image_file_obj)
    end
    open(text_file) do |text_file_obj|
      assert_kind_of TextMedia, dmf.create(text_file_obj)
    end

    # raise for unknown file path and File object
    assert_raises(UnknownContentError) {dmf.create(unknown_file)}
    open(unknown_file) do |unknown_file_obj|
      assert_raises(UnknownContentError) {dmf.create(unknown_file_obj)}
    end
  end

  def test_discrete_media_factory_creates_path_singleton_method
    pdf_file_path = sd('/book.pdf')

    media_obj = DiscreteMediaFactory.create(pdf_file_path)
    assert_equal pdf_file_path, media_obj.path

    open(pdf_file_path) do |pdf_file_obj|
      media_obj = DiscreteMediaFactory.create(pdf_file_obj)
    end
    assert_equal pdf_file_path, media_obj.path
  end

  def test_multipart_alternative_message_construction
    txt_data = "*Header*\nmessage\n"
    htm_data = "<html><body><h1>Header</h1><p>message</p></body></html>\n"
    txt_msg = TextMedia.new(txt_data)
    htm_msg = TextMedia.new(htm_data)

    txt_msg.content_type = 'text/plain; charset=us-ascii'
    htm_msg.content_type = 'text/html; charset=iso-8859-1'

    alt_msg = MultipartMedia::Alternative.new
    alt_msg.add_entity htm_msg
    alt_msg.add_entity txt_msg

    expected = IO.read(sd('/multipart_alternative.msg'))

    assert_equal_mime_message expected, alt_msg.to_s
  end

  def test_multipart_mixed_with_inline_and_attachment
    mixed_msg = MultipartMedia::Mixed.new

    open(sd('/image.jpg')) do |img_file|
      img_msg = ImageMedia.new(img_file.read, 'image/jpeg')
      mixed_msg.attach_entity(img_msg, 'filename' => img_file.path)
    end
    mixed_msg.inline_entity(TextMedia.new('This is plain text'))

    expected = IO.read(sd('/multipart_mixed_inline_and_attachment.msg'))

    assert_equal_mime_message expected, mixed_msg.to_s
  end

  def test_multipart_mixed_message_construction_using_media_factory
    img1 = sd('/image.jpg')
    img2 = sd('/ruby.png')
    txt  = sd('/index.html')
    bot_img = DiscreteMediaFactory.create(img1)
    top_img = DiscreteMediaFactory.create(img2)
    top_txt = DiscreteMediaFactory.create(txt)

    mixed_msg = MultipartMedia::Mixed.new
    mixed_msg.attach_entity(bot_img)
    mixed_msg.attach_entity(top_img)
    mixed_msg.inline_entity(top_txt)

    expected = IO.read(sd('/multipart_mixed_inline_and_attachment2.msg'))

    assert_equal_mime_message expected, mixed_msg.to_s
  end

  def test_multipart_form_data_with_mixed_entity
    txt = TextMedia.new('Joe Blow')
    img1 = DiscreteMediaFactory.create(sd('/image.jpg'))
    img2 = DiscreteMediaFactory.create(sd('/ruby.png'))

    mixed_msg = MultipartMedia::Mixed.new
    mixed_msg.attach_entity(img2)
    mixed_msg.attach_entity(img1)

    form = MultipartMedia::FormData.new
    form.add_entity(mixed_msg, 'pics')
    form.add_entity(txt, 'field1')

    # similar to example 6 in RFC1867
    expected = IO.read(sd('/multipart_form_data_mixed.msg'))

    assert_equal_mime_message expected, form.to_s
  end

  def test_multipart_related_html_message_with_embedded_image
    img = DiscreteMediaFactory.create(sd('/ruby.png'))
    img.content_transfer_encoding = 'binary'

    html_msg = TextMedia.new(<<-html, 'text/html; charset=iso-8859-1')
    <html>
    <body>
      <h1>HTML multipart/related message</h1>
      <p>txt before pix</p>
      <img alt="cool ruby" src="cid:#{img.content_id}"/>
      <p>txt after pix</p>
    </body>
    </html>
    html
    html_msg.content_transfer_encoding = '7bit'

    related_msg = MultipartMedia::Related.new
    related_msg.inline_entity(img)
    related_msg.add_entity(html_msg)

    expected = IO.read(sd('/multipart_related.msg'))

    assert_equal_mime_message expected, related_msg.to_s
  end

  def test_multipart_alternative_with_related_html_entity
    img = DiscreteMediaFactory.create(sd('/ruby.png'))
    img.content_transfer_encoding = 'binary'

    html_msg = TextMedia.new(<<-html, 'text/html; charset=iso-8859-1')
    <html>
    <body>
      <h1>HTML multipart/alternative message</h1>
      <p>txt before pix</p>
      <img alt="cool ruby" src="cid:#{img.content_id}"/>
      <p>txt after pix</p>
    </body>
    </html>
    html
    html_msg.content_transfer_encoding = '7bit'

    text_msg = TextMedia.new(<<-text)
    *HTML multipart/alternative message*
    txt before pix
    <cool ruby image>
    txt after pix
    text
    text_msg.content_transfer_encoding = '7bit'

    related_msg = MultipartMedia::Related.new
    related_msg.inline_entity(img)
    related_msg.add_entity(html_msg)

    alt_msg = MultipartMedia::Alternative.new
    alt_msg.add_entity(related_msg)
    alt_msg.add_entity(text_msg)

    expected = IO.read(sd('/multipart_alternative_related.msg'))

    assert_equal_mime_message expected, alt_msg.to_s
  end


  private

  #
  # Test the equality of the normalized +expected+ and +actual+ MIME messages.
  #
  def assert_equal_mime_message expected, actual
    assert_equal normalize_message(expected), normalize_message(actual)
  end

  #
  # Make messages comparable by removing *-ID header values, library version
  # comment in MIME-Version header, Date header value, multipart/related
  # content IDs, and boundaries.
  #
  def normalize_message message
    # these are very delicate REs that are inter-dependent, be careful
    match_id_headers  = /-ID: <[^>]+>\r\n/
    match_boundaries  = /Boundary_\d+\.\d+/
    match_lib_version = / \(Ruby MIME v\d\.\d\)/
    match_date_header = /^Date: .*\d{4}\r\n/
    match_related_cid = /cid:\d+\.\d+/

    message.
      gsub(match_related_cid, "cid").
      gsub(match_id_headers, "-ID:\r\n").
      gsub(match_boundaries, "Boundary_").
      sub(match_date_header, "Date:\r\n").
      sub(match_lib_version, " (Ruby MIME v0.0)")
  end

  #
  # Return the absolute path of +file+ under the test/scaffold directory.
  #
  def sd file
    @scaffold_dir ||= File.join(File.dirname(__FILE__), 'scaffold')
    @scaffold_dir + file
  end

end
