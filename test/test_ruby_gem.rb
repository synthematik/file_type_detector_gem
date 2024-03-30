# frozen_string_literal: true

require "test_helper"

class TestFileTypeDetectors < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FileTypeDetector::VERSION
  end

  def setup
    @file_path = 'test_file.pdf'
    File.write(@file_path, '%PDF-12345 Some content here')
  end

  def teardown
    File.delete(@file_path) if File.exist?(@file_path)
  end

  def test_raise_err_on_nonexistent_file
    non_existent_file_path = 'nonexistent_file.pdf'

    assert_raises(IOError) { FileTypeDetector.check(non_existent_file_path) }
  end

  def test_detect_pdf
    assert FileTypeDetector.check(@file_path)
  end

  def test_detect_non_pdf
    File.write(@file_path, 'This is not a PDF content')

    refute FileTypeDetector.check(@file_path)
  end

  def test_real_pdf
    assert FileTypeDetector.check("test/test_res/real_pdf.pdf")
  end

  def test_fake_pdf
    refute FileTypeDetector.check("test/test_res/real_png.pdf")
  end

end