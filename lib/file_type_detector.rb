# frozen_string_literal: true

require_relative "file_type_detector/version"

module FileTypeDetector
  class Error < StandardError; end

  # file_type_detector.rb

  class FileTypeDetector
    def initialize(file_path)
      @file_path = file_path
    end

    def detect
      detector.detect
    end

    private

    def detector
      detectors.detect { |detector| detector.supported? }
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

    def detect
      raise NotImplementedError, "#{self.class} must implement detect"
    end
  end

  # Detector for PDF files
  class PDFDetector < Detector
    def supported?
      File.extname(@file_path).downcase == '.pdf'
    end

    def detect
      # Определяем тип PDF-файла
      if File.read(@file_path, 5) == '%PDF-'
        'PDF'
      else
        'Unknown' # Если содержимое файла не соответствует формату PDF
      end
    end
  end

  # Detector for PNG files
  class PNGDetector < Detector
    def supported?
      File.extname(@file_path).downcase == '.png'
    end

    def detect
      # Определяем тип PNG-файла, возможно, с помощью какой-то библиотеки для работы с изображениями
      # В данном примере просто возвращаем строку 'PNG'
      'PNG'
    end
  end

end

def detect_file_type(file_path)
  File.open(file_path, 'rb') do |file|
    header = file.read(4)
    if header.start_with?('%PDF')
      return 'PDF'
    elsif header.start_with?('GIF8')
      return 'GIF'
    elsif header.start_with?("\x89PNG\r\n\x1A\n")
      return 'PNG'
    elsif header.start_with?("\xFF\xD8\xFF")
      return 'JPEG'
    else
      return 'Неизвестный тип файла'
    end
  end
end
