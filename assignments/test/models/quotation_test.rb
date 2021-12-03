require "test_helper"

class QuotationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should validate presence of author name" do
    quotation = Quotation.new
    assert !quotation.valid?
    assert_equal ["can't be blank"], quotation.errors[:author_name]
  end

  test "should validate presence of category" do
    quotation = Quotation.new
    assert !quotation.valid?
    assert_equal ["can't be blank"], quotation.errors[:category]
  end

  test "should validate presence of quote" do
    quotation = Quotation.new
    assert !quotation.valid?
    assert_equal ["can't be blank"], quotation.errors[:quote]
  end

end
