class StaticPagesController < ApplicationController
	require 'open-uri'

	def home
	end

	def fetch
		respond_to do |format|
			format.js do
				user = params[:user]
				user = user.gsub(/\s+/, "").parameterize
				region = params[:r].downcase
				summonerId = params[:summ_id]

				if (user && region && user.length > 2)
					key = "6aedadf3-97c8-45d1-b075-1b445918a377"
					if params[:type] == "name"
						url = URI.parse("https://prod.api.pvp.net/api/lol/#{region}/v1.1/summoner/by-name/#{user}?api_key=#{key}")
					elsif params[:type] == "game"
						url = URI.parse("https://prod.api.pvp.net/api/lol/#{region}/v1.1/game/by-summoner/#{summonerId}/recent?api_key=#{key}")						
					elsif params[:type] == "league"
						url = URI.parse("https://prod.api.pvp.net/api/#{region}/v2.1/league/by-summoner/#{summonerId}?api_key=#{key}")
					elsif params[:type] == "stats"
						url = URI.parse("https://prod.api.pvp.net/api/lol/#{region}/v1.1/stats/by-summoner/#{summonerId}/summary?api_key=#{key}")
					elsif params[:type] == "team"
						url = URI.parse("https://prod.api.pvp.net/api/#{region}/v2.1/team/by-summoner/#{summonerId}/summary?api_key=#{key}")
					end
					@response = nil
					open(url) do |http|
					  @response = http.read
					end
				end

			end
		end
	end

	def test
	end

end