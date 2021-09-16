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
        url = 'https://www.nytimes.com/international/section/world'
        html = URI.open(url)
        doc = Nokogiri::HTML(html)
        headers = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//h2/a")
        links = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//h2//a/@href")
        images = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//figure/a/img/@src")
        # authors = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//span[@class='css-1baulvz']")
        content = doc.xpath("//div[@class='css-gfgt40 ekkqrpp1']//article//p[@class='css-tskdi9 e4e4i5l4']")
        binding.pry

        news = []
        
        # binding.pry
        (0..headers.count - 1).each do |i|
            p i
            h = {}
            h[:header] = headers[i].text
            h[:link] = "https://www.nytimes.com/section" + links[i].text
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
end

news = BasicsController.new
news.news


