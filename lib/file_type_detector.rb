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
    if error_handling(file_path)
      File.read(file_path, 5) == "%PDF-"
    end
  end

  def self.docx_check(file_path)
    if error_handling(file_path)
      File.open(file_path, "rb") { |file| file.read(4) } == "PK\x03\x04"
    end
  end



  # =============================================
  FILE_CHECKS = [
    method(:pdf_check),
    method(:docx_check),
    # Add your methods here
  ].freeze

end