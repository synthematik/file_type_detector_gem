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
