require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall_url)

    page = Nokogiri::HTML(open(townhall_url))

    email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    return email
end

def get_townhall_urls 
    href_array = []
    names_array = []

    home_page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))

    home_page.xpath('//a[@class="lientxt"]').each do |a|
        names_array << a.text 
    end



    home_page.xpath('//a[@class="lientxt"]').each do |a|
        href_array << a['href']
    end

    href_array.length.times do |i| ##### Just to remove a "." in the beggining of URL and add the full http.... 
        href_array[i][0] = ""
        href_array[i][0] = 'http://annuaire-des-mairies.com/'
    end
    return href_array, names_array
end




href_array, names_array = get_townhall_urls
result = Hash.new
names_array.length.times do |i|
    result[names_array[i]] = get_townhall_email(href_array[i])
end

print result






