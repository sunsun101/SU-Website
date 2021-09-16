require 'nokogiri'
require 'open-uri'
require 'pry'

class BasicsController < ApplicationController

    def parse_ktm_news
        url = 'https://kathmandupost.com/world'
        html = URI.open(url)
        doc = Nokogiri::HTML(html)
        headers = doc.xpath("//div[@class='block--morenews']/article/a/h3")
        links = doc.xpath("//div[@class='block--morenews']/article/a/@href")
        images = doc.xpath("//div[@class='block--morenews']/article/div/figure/a/img/@data-src")
        authors = doc.xpath("//div[@class='block--morenews']/article/span/a")
        content = doc.xpath("//div[@class='block--morenews']/article/p")

        news = []
        
        # binding.pry
        (0..headers.count - 1).each do |i|
            h = {}
            h[:header] = headers[i].text
            h[:link] = "https://kathmandupost.com" + links[i].text
            h[:image] = images[i].text
            h[:author] = authors[i].text
            h[:content] = content[i].text
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
        headers1  = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//h2/a")
        headers2 = doc.xpath("//li[@class='css-ye6x8s']//a/h2")
        links1 = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//h2//a/@href")
        links2 = doc.xpath("//li[@class='css-ye6x8s']//a/@href")
        images1 = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//figure/a/img/@src")
        images2 = doc.xpath("//li[@class='css-ye6x8s']//a//figure//img/@src")
        # authors = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//span[@class='css-1baulvz']")
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
            h[:header] = headers[i].text
            h[:link] = "https://www.nytimes.com" + links[i].text
            h[:image] = images[i].text
            # h[:author] = authors[i].text
            h[:content] = content[i].text
            news << h
        end
        news
    end

    def news
        @ktm_news = parse_ktm_news
        @ny_news = parse_ny_news
        
    end

    def divide_by_zero
        Rails.logger.warn 'About to divide by 0'
        var = 4/0
    end
end

news = BasicsController.new
news.news


