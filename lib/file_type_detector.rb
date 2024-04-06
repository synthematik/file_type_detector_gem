# frozen_string_literal: true

require_relative "file_type_detector/version"

# Provides methods for detecting file types based on their content.
module FileTypeDetector
  # Determines the file type based on its content.
  #
  # @param [String] file_path The path to the file to be checked.
  # @return [Boolean] Returns true if the file type is recognized, otherwise false.
  def self.check(file_path)
    if error_handling(file_path)
      file_extension = File.extname(file_path).downcase

      FILE_CHECKS.each do |check_function|
        return check_function.call(file_path) if file_extension == ".#{check_function.name.to_s.split("_")[0]}"
      end
    end

    false
  end

  # Identifies the file type based on its content.
  #
  # @param [String] file_path The path to the file to be identified.
  # @return [String] Returns the identified file type.
  def self.identify(file_path)
    return unless error_handling(file_path)

    FILE_CHECKS.find { |fn| fn.call(file_path)}.name.to_s.split("_")[0][1..]
  end

  # =============================================
  # Error handling for file operations.
  #
  # @param [String] file_path The path to the file to be checked.
  # @return [Boolean] Returns true if no errors are encountered, otherwise raises IOError.
  def self.error_handling(file_path)
    raise IOError, "File '#{file_path}' not found" unless File.exist?(file_path)
    raise IOError, "File '#{file_path}' is not a file" unless File.file?(file_path)
    raise IOError, "File '#{file_path}' is not available for reading" unless File.readable?(file_path)

    true
  end

  # =============================================
  # Checks if the file has a PDF format.
  #
  # @param [String] file_path The path to the file to be checked.
  # @return [Boolean] Returns true if the file has a PDF format, otherwise false.
  def self.pdf_check(file_path)
    return unless error_handling(file_path)

    File.read(file_path, 5) == "%PDF-"
  end

  # Checks if the file has a DOCX format.
  #
  # @param [String] file_path The path to the file to be checked.
  # @return [Boolean] Returns true if the file has a DOCX format, otherwise false.
  def self.docx_check(file_path)
    return unless error_handling(file_path)

    File.open(file_path, "rb") { |file| file.read(4) } == "PK\x03\x04"
  end

  # Checks if the file has a PNG format.
  #
  # @param [String] file_path The path to the file to be checked.
  # @return [Boolean] Returns true if the file has a PNG format, otherwise false.
  def self.png_check(file_path)
    return unless error_handling(file_path)

    first_bytes = File.open(file_path, "rb") { |file| file.read(16) }
    first_bytes.start_with?("\x89PNG\r\n\x1A\n".b)
  end

  # Checks if the file has a GIF format.
  #
  # @param [String] file_path The path to the file to be checked.
  # @return [Boolean] Returns true if the file has a GIF format, otherwise false.
  def self.gif_check(file_path)
    return unless error_handling(file_path)

    first_bytes = File.open(file_path, "rb") { |file| file.read(6) }
    %w[GIF87a GIF89a].include?(first_bytes)
  end

  # Checks if the file has a JPEG format.
  #
  # @param [String] file_path The path to the file to be checked.
  # @return [Boolean] Returns true if the file has a JPEG format, otherwise false.
  def self.jpeg_check(file_path)
    return unless error_handling(file_path)

    first_bytes = File.open(file_path, "rb") { |file| file.read(2) }
    first_bytes == "\xFF\xD8".b

  end

  # Checks if the file has a JPG format.
  #
  # @param [String] file_path The path to the file to be checked.
  # @return [Boolean] Returns true if the file has a JPG format, otherwise false.
  def self.jpg_check(file_path)
    jpeg_check(file_path)
  end

  # Checks if the file has a JSON format.
  #
  # @param [String] file_path The path to the file to be checked.
  # @return [Boolean] Returns true if the file has a JSON format, otherwise false.
  def self.json_check(file_path)
    return unless error_handling(file_path)

    first_chars = File.open(file_path, "rb") { |file| file.read(2) }
    first_chars.start_with?("{") || first_chars.start_with?("[")
  end

  # Checks if the file has a XML format.
  #
  # @param [String] file_path The path to the file to be checked.
  # @return [Boolean] Returns true if the file has a XML format, otherwise false.
  def self.xml_check(file_path)
    return unless error_handling(file_path)

    File.open(file_path, "rb") { |file| file.read(2) } == "<?"
  end

  # =============================================
  # Array containing check functions for different file types.
  FILE_CHECKS = [
    method(:pdf_check),
    method(:docx_check),
    method(:png_check),
    method(:gif_check),
    method(:jpeg_check),
    method(:jpg_check),
    method(:json_check),
    method(:xml_check)
    # Add your methods here
  ].freeze

end
