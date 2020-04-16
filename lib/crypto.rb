require 'nokogiri'
require 'open-uri'


def web_scrapper
    array_names = []
    array_price = []
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    
    page.xpath('/html/body/div/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[2]/div').each do |tr|
        array_names << tr.text 
        end

    page.xpath('/html/body/div/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a').each do |tr|
        array_price << tr.text
        end
    
    result = Hash.new
        array_names.length.times do |i|
            result[array_names[i]] = array_price[i]
    end
    print result
end

web_scrapper()
