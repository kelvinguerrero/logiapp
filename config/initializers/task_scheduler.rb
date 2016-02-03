require 'rufus/scheduler'
scheduler = Rufus::Scheduler.new

scheduler.every '4m' do
  require "net/http"
  require "uri"
  url = 'https://infinite-savannah-3539.herokuapp.com/'
  Net::HTTP.get_response(URI.parse(url))
end