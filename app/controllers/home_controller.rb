require 'rest-client'
require "cgi"
require 'logger'
require 'active_support/json'
require 'json'

class HomeController < ApplicationController
  def index
      @api_key = 'api_key=fd609a75-8aa4-4242-b09c-10c11e722804'
    def getSummoner(name)
      @url = 'https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name'
      endpoint = name
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
        @response= JSON.parse(@response.body)[name.downcase]
    end

    def get_games(summonerID)
      @url = 'https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner'

      endpoint = summonerID.to_s
      query = ::CGI::escape(endpoint)
      params = @api_key
      url_components = [@url, endpoint]
      @url =  "#{url_components.join('/')}/recent?#{params}"
      @url2 = @url
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
        @response= JSON.parse(@response.body)['games']



    end
=begin
    def match_history(name)
      @url = 'https://na.api.pvp.net/api/lol/na/v2.2/matchhistory'
      endpoint = name
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

    if params[:search]
      @result = getSummoner(:search)
      @id = getSummoner(:search)['id']
      @name = getSummoner(:search)['name']
      @profileIconId = getSummoner(:search)['profileIconId']
      @summonerLevel = getSummoner(:search)['summonerLevel']

    else
=end
      @result = getSummoner('RodMal')
      @id = getSummoner('RodMal')['id']
      @name = getSummoner('RodMal')['name']
      @profileIconId = getSummoner('RodMal')['profileIconId']
      @summonerLevel = getSummoner('RodMal')['summonerLevel']

    #end
      @games = get_games(@id)

  	#@url= 'https://na.api.pvp.net/api/lol/na/v1.2'
  end
end
