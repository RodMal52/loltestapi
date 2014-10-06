require 'rest-client'
require "cgi"
require 'logger'
require 'active_support/json'

class HomeController < ApplicationController
  def index
  	@url = 'https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name'

  	#@url= 'https://na.api.pvp.net/api/lol/na/v1.2'
  	@api_key = 'api_key=fd609a75-8aa4-4242-b09c-10c11e722804'
  	endpoint = 'RodMal'
  	query = ::CGI::escape(endpoint)
	params = @api_key
	
	

    url_components = [@url, endpoint]
	
    @url =  "#{url_components.join('/')}?#{params}"
    
    header = {}
      begin
        @response = RestClient.get @url, header
      rescue Exception => e
        logger.error "==================================================="
        logger.debug "An exception occured while processing GET request to url: #{@url}"
        logger.error e.to_s
        logger.error "==================================================="
        @response = { error: e.message}.to_json
      end

      @response

  end
end
