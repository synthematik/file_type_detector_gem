# file_type_detector_sfedu

**file_type_detector_sfedu** is a Ruby gem that allows you to determine the type of files based on their extension or content.

## Installation

Add this gem to your Gemfile and run `bundle install`:

```ruby
gem "file_type_detector_sfedu"
```

Alternatively, install it directly using the gem command:

```ruby
gem install file_type_detector_sfedu
```

## Usage

To use the gem, you need to call the `check` method with a parameter in the form of a file path:
```ruby
require "file_type_detector_sfedu"

puts FileTypeDetector.check("path/to/your/file.pdf") # if it's truly pdf, value will be true, unless - false
```
`check` method will automatically detect the file type by its extension and tell if its contents match the extension.

You can also use a specific detector:
```ruby
puts FileTypeDetector.pdf_check("path/to/your/real_pdf.pdf") # true
puts FileTypeDetector.pdf_check("path/to/your/fake_pdf.pdf") # false

puts FileTypeDetector.docx_check("path/to/your/real_docx.docx") # true
puts FileTypeDetector.docx_check("path/to/your/fake_docx.docx") # false
```

## Supported File Types
The gem provides support for detecting the following file types:

- PDF
- DOCX
- PNG
- GIF
- JPEG(TODO)
- ZIP(TODO)

## Contributing and links

You can contribute to the development of the gem by creating new detectors for other file types and improving existing code. Report bugs and submit feature requests through the [GitHub repository](https://github.com/synthematik/file_type_detector_gem).

You can visit our gem's page here - [Rubygems.org](https://rubygems.org/gems/file_type_detector_sfedu)
## License

This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
