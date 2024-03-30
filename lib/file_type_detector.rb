# frozen_string_literal: true

require_relative "file_type_detector/version"

module FileTypeDetector
  class Error < StandardError; end

  # file_type_detector.rb

  class FileTypeDetector
    def initialize(file_path)
      unless File.exist?(file_path)
        raise IOError, "File '#{file_path}' not found"
      end
      @file_path = file_path
    end

    def detect
      detectors.find(&:supported?).check
    end

    def detectors
      [
        PDFDetector.new(@file_path),
        PNGDetector.new(@file_path),
      # Добавьте сюда новые детекторы для других типов файлов по мере необходимости
      ]
    end
  end

  # Base Detector class
  class Detector
    def initialize(file_path)
      @file_path = file_path
    end

    def supported?
      raise NotImplementedError, "#{self.class} must implement supported?"
    end

    def check
      raise NotImplementedError, "#{self.class} must implement detect"
    end
  end

  # Detector for PDF files
  class PDFDetector < Detector
    def supported?
      File.extname(@file_path).downcase == '.pdf'
    end

    def check
      # Определяем тип PDF-файла
      File.read(@file_path, 5) == '%PDF-'
    end
  end

  # Detector for PNG filesбля
  class PNGDetector < Detector
    def supported?
      File.extname(@file_path).downcase == '.png'
    end

    def check
      # Определяем тип PNG-файла, возможно, с помощью какой-то библиотеки для работы с изображениями
      false
    end
  end

end