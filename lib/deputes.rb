require 'nokogiri'
require 'open-uri'

def get_deputes_url
    url_array = []
    home_page = Nokogiri::HTML(open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))

    home_page.xpath('/html/body/div/div[3]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li/a').each do |li, ul, div|
        url_array << li['href']
    end

    url_array.length.times do |i| ##### add the full http.... 
        url_array[i][0] = "http://www2.assemblee-nationale.fr/"
    end

    return url_array
end


def get_deputes_email_and_name(depute_url)


    page = Nokogiri::HTML(open(depute_url))
    

    email = page.xpath('/html/body/div/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text     ##Get Email

    name = page.xpath('/html/body/div/div[3]/div/div/div/section[1]/div/article/div[2]/h1').text    ##Get Name
    name.sub!('M.', '')
    name.sub!('Mme', '')

    return name, email

end


url_array = get_deputes_url
result = Hash.new

url_array.length.times do |i|
    name, email = get_deputes_email_and_name(url_array[i])

    result[name] = email
    puts result
end
