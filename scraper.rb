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
job_listings.each do |job_listing|
job={
    title: job_listing.css('.jobTitle-color-purple span').text,
    company: job_listing.css('span.companyName').text,
    location: job_listing.css('div.companyLocation')
}
# add individual job to jobs array
# HOW ELEGANT THIS IS, RIGHT?
jobs << job
end
byebug #sets a debugger


end

scraper


