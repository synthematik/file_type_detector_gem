# frozen_string_literal: true

require_relative "file_type_detector/version"

module FileTypeDetector

  # @param [String] file_path
  # @return [Boolean]
  def self.check(file_path)
    unless File.exist?(file_path)
      raise IOError, "File '#{file_path}' not found"
    end

    file_extension = File.extname(file_path).downcase

    # detectors.each do |check_function|
    #   return true if file_extension == ".#{check_function.name.split('_')[0]}" && check_function.call(file_path)
    # end
    FILE_CHECKS.each do |check_function|
      if file_extension == ".#{check_function.name.to_s.split('_')[0]}"
        return check_function.call(file_path)
      end
    end

    return false
  end

  # =============================================
  # Где писать свои методы
  def self.pdf_check(file_path)
    File.read(file_path, 5) == '%PDF-'
  end



  # =============================================
  FILE_CHECKS = [
    method(:pdf_check),
    # добавить сюда свой метод
  ]

end