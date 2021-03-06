module SvgHelper
  def svg_tag(file_path, options = {})
    options[:width], options[:height] = extract_dimensions(options[:size]) if options[:size]

    file_name = extract_filename(file_path)
    file = File.read(Rails.root.join('public', 'packs', 'packs/images', file_name))
    document = Nokogiri::HTML::DocumentFragment.parse file
    svg = document.at_css 'svg'
    
    svg['class']  = options[:class] if options[:class]
    svg['id']     = options[:id] if options[:id]
    svg['width']  = options[:width] if options[:width]
    svg['height'] = options[:height] if options[:height]

    document.to_html.html_safe
  end

  private

  def extract_filename(file_path)
    Webpacker.manifest.lookup!(file_path).split('/').last
  end

  def extract_dimensions(options)
    options.split('x')
  end
end
