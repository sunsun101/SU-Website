require 'test_helper'

class BasicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quote = quotations(:one)
  end
  test 'should get articles' do
    get basics_news_path
    assert_response :success
  end

  test 'should get dividebz' do
    get basics_divide_path
    assert_response :success
  end

  test 'should kill cookie' do
    get basics_quotations_path, params: { restore: true }
  end

  test 'should split the input cookies if there are cookies' do
    get basics_quotations_path, headers: { 'HTTP_COOKIE' => 'quotations_id=1;' }, params: { quotation_id: 1 }
  end

  test 'should set the cookies if empty' do
    get basics_quotations_path, params: { quotation_id: 1 }
  end

  test 'create quote using category if no new category given' do
    assert_difference('Quotation.count') do
      post basics_quotations_path,
           params: { quotation: { author_name: @quote.author_name, category: @quote.category, quote: @quote.quote } }
    end
  end

  test 'create quote using new category if it exits' do
    assert_difference('Quotation.count') do
      post basics_quotations_path,
           params: { quotation: { author_name: @quote.author_name, newcategory: 'New Category', quote: @quote.quote } }
    end
  end

  test 'search quoatations' do
    get basics_quotations_path, params: { search: 'test' }
  end

  test 'sort by date' do
    get basics_quotations_path, params: { sort_by: 'date' }
  end

  test 'if it has import link' do
    get basics_quotations_path, params: { import_link: 'https://web4.cs.ait.ac.th/basics/quotations.xml' }
  end

  test 'has no import link' do
    get basics_quotations_path, params: { import_link: 'import link' }
  end
end
