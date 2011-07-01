module Cuba::Helpers
  def section(key, *args, &block)
    @sections ||= Hash.new{ |k,v| k[v] = [] }
    if block_given?
      @sections[key] << block
    else
      @sections[key].inject(''){ |content, block| content << block.call(*args) } if @sections.keys.include?(key)
    end
  end

  def title(page_title, show_title = true)
    section(:title) { page_title.to_s }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def partial(template, locals = {})
    render("views/#{template}.haml", locals)
  end

  def layout(content)
    partial("layout", content: content)
  end

  def haml(template, locals = {})
    layout(partial(template, locals))
  end

#  BLACK_PIXEL = 0
#  WHITE_PIXEL = 255
#  def to_image_file(filename,qr)
#    margin = 4
#    img_width  = qr.module_count + (2 * margin)
#    img_height = qr.module_count + (2 * margin)
#
#    # Make arrays of pixel data to use for the margins.
#    vert_margin = [].fill(WHITE_PIXEL, 0, margin * img_width)
#    horz_margin = [].fill(WHITE_PIXEL, 0, margin)
#    # Convert QR Code to pixel data, starting with the top margin.
#    pixels = vert_margin
#    qr.modules.each_index do |x|
#      pixels += horz_margin
#      qr.modules.each_index do |y|
#        pixels << (qr.dark?(x, y) ? BLACK_PIXEL : WHITE_PIXEL)
#      end
#      pixels += horz_margin
#    end
#
#    # Add in the bottom margin
#    pixels += vert_margin
#    image = Magick::Image.new(img_width, img_height)
#    image.import_pixels(
#      0,
#      0,
#      img_width,
#      img_height,
#      "I",              # grayscale
#      pixels,
#      Magick::CharPixel # pixel range 0-255
#    )
#    image.sample(200,200)
#    image.write(filename)
#  end
end

class Cuba::Ron
  include Cuba::Helpers
end
