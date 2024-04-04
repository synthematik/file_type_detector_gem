# frozen_string_literal: true

require_relative "file_type_detector/version"

module FileTypeDetector
  # @param [String] file_path
  # @return [Boolean]
  def self.check(file_path)
    if error_handling(file_path)
      file_extension = File.extname(file_path).downcase

      FILE_CHECKS.each do |check_function|
        return check_function.call(file_path) if file_extension == ".#{check_function.name.to_s.split("_")[0]}"
      end
    end

    false
  end

  # =============================================
  # Error handling
  def self.error_handling(file_path)
    raise IOError, "File '#{file_path}' not found" unless File.exist?(file_path)
    raise IOError, "File '#{file_path}' is not a file" unless File.file?(file_path)
    raise IOError, "File '#{file_path}' is not available for reading" unless File.readable?(file_path)

    true
  end

  # =============================================
  # Write your methods here
  def self.pdf_check(file_path)
    return unless error_handling(file_path)

    File.read(file_path, 5) == "%PDF-"

  end

  def self.docx_check(file_path)
    return unless error_handling(file_path)

    File.open(file_path, "rb") { |file| file.read(4) } == "PK\x03\x04"

  end

  def self.png_check(file_path)
    return unless error_handling(file_path)

    first_bytes = File.open(file_path, "rb") { |file| file.read(16) }
    first_bytes.start_with?("\x89PNG\r\n\x1A\n".b)

  end

  def self.gif_check(file_path)
    return unless error_handling(file_path)

    first_bytes = File.open(file_path, "rb") { |file| file.read(6) }
    %w[GIF87a GIF89a].include?(first_bytes)

  end

  def self.jpeg_check(file_path)
    return unless error_handling(file_path)

    first_bytes = File.open(file_path, "rb") { |file| file.read(2) }
    first_bytes == "\xFF\xD8".b

  end

  def self.jpg_check(file_path)
    jpeg_check(file_path)
  end

  def self.json_check(file_path)
    return unless error_handling(file_path)

    first_chars = File.open(file_path, "rb") { |file| file.read(2) }
    first_chars.start_with?("{") || first_chars.start_with?("[")
  end

  def self.xml_check(file_path)
    return unless error_handling(file_path)

    (File.open(file_path, "rb") { |file| file.read(2) }) == "<?"

  end

  # =============================================
  FILE_CHECKS = [
    method(:pdf_check),
    method(:docx_check),
    method(:png_check),
    method(:gif_check),
    method(:jpeg_check),
    # Add your methods here
  ].freeze

end
