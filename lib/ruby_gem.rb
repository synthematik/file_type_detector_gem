# frozen_string_literal: true

require_relative "ruby_gem/version"

module RubyGem
  class Error < StandardError; end
  # Your code goes here...
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
