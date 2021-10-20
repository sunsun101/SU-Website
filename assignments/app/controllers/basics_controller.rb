require 'nokogiri'
require 'open-uri'
require 'pry'

class BasicsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def parse_ktm_news
    url = 'https://kathmandupost.com/world'
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    headers = doc.xpath("//div[@class='block--morenews']/article/a/h3")
    links = doc.xpath("//div[@class='block--morenews']/article/a/@href")
    images = doc.xpath("//div[@class='block--morenews']/article/div/figure/a/img/@data-src")
    content = doc.xpath("//div[@class='block--morenews']/article/p")

    news = []

    # binding.pry
    (0..headers.count - 1).each do |i|
      h = {}
      h[:header] = headers[i] ? headers[i].text : ''
      h[:link] = links[i] ? ('https://kathmandupost.com' + links[i].text) : ''
      h[:image] = images[i] ? images[i].text : ''
      h[:content] = content[i] ? content[i].text : ''
      news << h
    end
    news
  end

  def parse_ny_news
    headers = []
    links = []
    images = []
    content = []

    url = 'https://www.nytimes.com/international/section/world'
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    headers1 = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//h2/a")
    headers2 = doc.xpath("//li[@class='css-ye6x8s']//a/h2")
    links1 = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//h2//a/@href")
    links2 = doc.xpath("//li[@class='css-ye6x8s']/div/div/a/@href")
    images1 = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//figure/a/img/@src")
    images2 = doc.xpath("//li[@class='css-ye6x8s']//a//figure//img/@src")
    content1 = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//p[@class='css-tskdi9 e4e4i5l4']")
    content2 = doc.xpath("//li[@class='css-ye6x8s']//a/p")
    headers = headers1 + headers2
    links = links1 + links2
    images = images1 + images2
    content = content1 + content2

    # binding.pry

    news = []
    (0..headers.count - 1).each do |i|
      h = {}
      h[:header] = headers[i] ? headers[i].text : ''
      h[:link] = links[i] ? ('https://www.nytimes.com' + links[i].text) : ''
      h[:image] = images[i] ? images[i].text : ''
      # h[:content] = content[i] ?(content[i].text):''
      news << h
    end
    news
  end

  def news
    @ktm_news = parse_ktm_news
    @ny_news = parse_ny_news
  end

  def divide
    Rails.logger.warn 'About to divide by 0'
    4 / 0
  rescue StandardError => e
    @error_msg = e.message
    @stack_trace = e.backtrace
  end

  def index; end

  def killCookie
    cookies.delete :quotations_id if params[:restore]
  end

  def quotations
    @quotation = Quotation.new

    killCookie

    if params[:quotation_id]
      if cookies[:quotations_id]
        values = []
        cookies[:quotations_id].split('&').each do |i|
          values << i
        end
        values << params[:quotation_id]
        cookies[:quotations_id] = values.join(',')
      else
        cookies[:quotations_id] = params[:quotation_id]
      end
    end

    if params[:quotation]
      @quotation = if params[:quotation][:newcategory].present?
                     Quotation.new(author_name: params[:quotation][:author_name],
                                   category: params[:quotation][:newcategory], quote: params[:quotation][:quote])
                   else
                     Quotation.new(author_name: params[:quotation][:author_name],
                                   category: params[:quotation][:category], quote: params[:quotation][:quote])
                   end
      if @quotation.save
        flash[:notice] = 'Quotation was successfully created.'
        @quotation = Quotation.new
      end
    end

    if cookies[:quotations_id]
      @quotations = Quotation.where('id NOT IN (?)', cookies[:quotations_id].split(','))
      @cookie_exist = true
    else
      @quotations = Quotation.all
      @cookie_exist = false
    end

    if params[:search] && params[:search].present?
      @quotations = @quotations.where('author_name ILIKE ? OR quote ILIKE ?', '%' + params[:search] + '%',
                                      '%' + params[:search] + '%')
      @resp = 'No results found' if @quotations.empty?
    end
    @quotations = if params[:sort_by] == 'date'
                    @quotations.order(:created_at)
                  else
                    @quotations.order(:category)
                  end

    export_data
    import_data
  end

  def export_data
    # Code to download the the JSON and XML files
    # if params[:export_type]
    #   if params[:export_type] == 'JSON'
    #     json_data = @quotations.to_json
    #     send_data json_data, :type => "application/json; header=present", :disposition => "attachment; filename=quotations.json"
    #   else
    #     xml_data = JSON.parse(@quotations.to_json).to_xml
    #     send_data xml_data, :type => "application/xml; header=present", :disposition => "attachment; filename=quotations.xml"
    #   end
    # end
    respond_to do |format|
      format.html
      format.xml { render xml: @quotations.as_json }
      format.json { render json: @quotations }
    end
  end

  def import_data
    if params[:import_link].present?
      begin
        response = URI.open(params[:import_link]).string
      rescue StandardError => e
        Rails.logger.info('Could not import from the link')
        response = ''
      end
      xml_content = Nokogiri::XML(response)
      xml_content.css('object').each do |tag|
        children = tag.children
        @quotation = Quotation.new(author_name: children.css('author-name').inner_text,
                                   category: children.css('category').inner_text, quote: children.css('quote').inner_text)
        @quotation.save
      end
    end
  end
end
