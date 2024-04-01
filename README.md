# file_type_detector_sfedu

**file_type_detector_sfedu** is a Ruby gem that allows you to determine the type of files based on their extension or content.

## Installation

Add this gem to your Gemfile and run `bundle install`:

```ruby
gem 'file_type_detector_sfedu'
```

Alternatively, install it directly using the gem command:

```ruby
gem install file_type_detector_sfedu
```

## Usage

To use the gem, you need to create an instance of FileTypeDetector::FileTypeDetector, specifying the path to the file as the constructor argument. Then call the detect method to determine the file type.

```ruby
require 'file_type_detector_sfedu'

detector = FileTypeDetector::FileTypeDetector.new('path/to/your/file.pdf')
puts detector.detect
```
Please replace `"path/to/your/file.pdf"` with the path to your file that you want to check.

## Supported File Types
The gem provides support for detecting the following file types:

- PDF
- DOCX
- PNG
- JPEG

## Contributing

You can contribute to the development of the gem by creating new detectors for other file types and improving existing code. Report bugs and submit feature requests through the [GitHub repository](https://github.com/synthematik/file_type_detector_gem).

## License

This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
