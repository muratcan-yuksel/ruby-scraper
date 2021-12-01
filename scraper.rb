require "nokogiri"
require "httparty"
require "byebug"

def scraper
url = "https://fr.indeed.com/jobs?q=smart%20contract&l="
# get the raw html with httparty 
unparsed_page= HTTParty.get(url)
#parse the page with nokogiri
parsed_page= Nokogiri::HTML(unparsed_page)
# create new array for jobs
jobs= Array.new
# byebug #sets a debugger

job_listings= parsed_page.css('div.slider_container')
page=1


#job listings per page
per_page= job_listings.count
#total number of job listings on the site
total=parsed_page.css('div#searchCountPages').text.split(' ')[3].to_i

last_page=(total.to_f / per_page.to_f).round
while page <= last_page
    pagination_url="https://fr.indeed.com/jobs?q=smart+contract&start=#{page * 10}"
    puts pagination_url
    puts "Page: #{page}"
    puts ''
    
    pagination_unparsed_page= HTTParty.get(pagination_url)
    pagination_parsed_page= Nokogiri::HTML(pagination_unparsed_page)
    pagination_job_listings=  pagination_parsed_page.css('div.slider_container')



    pagination_job_listings.each do |job_listing|
job={
    title: job_listing.css('.jobTitle-color-purple span').text,
    company: job_listing.css('span.companyName').text,
    location: job_listing.css('div.companyLocation')
}
# add individual job to jobs array
# HOW ELEGANT THIS IS, RIGHT?
jobs << job
puts "Added #{job[:title]}"
puts ""
end
page += 1
end
byebug #sets a debugger


end

scraper


parsed_page.css('div#searchCountPages').text