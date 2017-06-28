require_dependency "property_web_scraper/application_controller"

module PropertyWebScraper
  class ScraperController < ApplicationController

    def submit
      scraper_name = params[:scraper][:scraper_name]
      redirect_to "/scrapers/#{scraper_name}"
    end

    def show
      @import_host = PropertyWebScraper::ImportHost.find_by(id: params[:id])
    end

    def welcome
      @scraper_configs_coll = PropertyWebScraper::ImportHost.all
      
    end

    def retrieve

      unless params[:source_url].present?
        return render json: { error: "Please provide url."}, status: 422
      end
      source_url = params[:source_url]

      @import_host = PropertyWebScraper::ImportHost.find_by(id: params[:id])
      web_scraper = PropertyWebScraper::Scraper.new(@import_host.scraper_name)
      retrieved_properties = web_scraper.retrieve_from_webpage source_url

      render json: retrieved_properties


      # render json: {
      #   success: true
      # }
    end
  end
end