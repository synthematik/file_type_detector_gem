# frozen_string_literal: true

require "./test/test_helper"

class TestPDFCheck < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FileTypeDetector::VERSION
  end

  def test_real_pdf
    assert FileTypeDetector.check("test/test_resources/test_pdf_resources/real_pdf.pdf")
  end

  def test_fake_pdf
    refute FileTypeDetector.check("test/test_resources/test_pdf_resources/real_png.pdf")
  end

  def test_not_pdf
    refute FileTypeDetector.docx_check("test/test_resources/test_png_resources/real_png.png")
  end
end

class TestDocxCheck < Minitest::Test
  def test_real_docx
    assert FileTypeDetector.docx_check("test/test_resources/test_docx_resources/real_docx.docx")
  end

  def test_fake_docx
    refute FileTypeDetector.docx_check("test/test_resources/test_docx_resources/fake_docx.docx")
  end

  def test_not_docx
    refute FileTypeDetector.docx_check("test/test_resources/test_png_resources/real_png.png")
  end
end

class TestError < Minitest::Test
  def test_file_not_exist
    error = assert_raises(IOError, "File '/non_existent_file_path/file.some' not found") do
      FileTypeDetector.error_handling("/non_existent_file_path/file.some")
    end
    assert_equal "File '/non_existent_file_path/file.some' not found", error.message
  end

  def test_file_exist
    assert FileTypeDetector.error_handling("test/test_resources/test_png_resources/real_png.png")
  end

  def test_file_not_a_file
    error = assert_raises(IOError, "File 'test/test_resources/test_png_resources/' is not a file") do
      FileTypeDetector.error_handling("test/test_resources/test_png_resources/")
    end
    assert_equal("File 'test/test_resources/test_png_resources/' is not a file", error.message)
  end

  def test_file_a_file
    assert FileTypeDetector.error_handling("test/test_resources/test_png_resources/real_png.png")
  end

  def test_file_not_readable
    assert FileTypeDetector.error_handling("test/test_resources/test_png_resources/real_png.png")
  end
end

class TestPngCheck < Minitest::Test
  def test_real_png
    assert FileTypeDetector.png_check("test/test_resources/test_png_resources/real_png.png")
  end

  def test_fake_png
    refute FileTypeDetector.png_check("test/test_resources/test_png_resources/real_pdf.png")
  end

  def test_not_png
    refute FileTypeDetector.png_check("test/test_resources/test_docx_resources/real_docx.docx")
  end
end

class TestGifCheck < Minitest::Test
  def test_real_gif
    assert FileTypeDetector.gif_check("test/test_resources/test_gif_resources/real_gif_1.gif")
  end

  def test_fake_gif
    refute FileTypeDetector.gif_check("test/test_resources/test_gif_resources/fake_gif.gif")
  end

  def test_not_gif
    refute FileTypeDetector.gif_check("test/test_resources/test_png_resources/real_png.png")
  end
end


class TestJpegCheck < Minitest::Test
  def test_real_jpeg
    assert FileTypeDetector.jpeg_check("test/test_resources/test_jpeg_resources/real_jpeg.jpeg")
  end

  def test_fake_jpeg
    refute FileTypeDetector.jpeg_check("test/test_resources/test_jpeg_resources/fake_jpeg.jpeg")
  end

  def test_not_jpeg
    refute FileTypeDetector.jpeg_check("test/test_resources/test_png_resources/real_png.png")
  end
end

class TestJsonCheck < Minitest::Test
  def test_fake_json
    refute FileTypeDetector.json_check("test/test_resources/test_json_resources/fake_json.json")
  end

  def test_real_json
    assert FileTypeDetector.json_check("test/test_resources/test_json_resources/real_json.json")
  end

  def test_not_json
    refute FileTypeDetector.json_check("test/test_resources/test_png_resources/real_png.png")
  end

end