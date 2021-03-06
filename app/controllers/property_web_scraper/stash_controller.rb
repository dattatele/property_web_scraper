require_dependency 'property_web_scraper/application_controller'

module PropertyWebScraper
  class StashController < ApplicationController
    # below to avoid ActionController::InvalidAuthenticityToken error when posting from chrome extension
    protect_from_forgery with: :null_session

    def show_prop
      fb_instance_id = Rails.application.secrets.fb_instance_id
      base_uri = "https://#{fb_instance_id}.firebaseio.com/"
      firebase = Firebase::Client.new(base_uri)
      @client_key = params["client_id"]
      @prop_key = params["prop_id"]
      response = firebase.get("props/" + @client_key + "/" + @prop_key )

      @prop = response.body
      # byebug
      # push("todos", { :name => 'Pick the milk', :priority => 1 })
      # response.success? # => true
      # response.code # => 200
      # response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
      # response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'

      render 'property_web_scraper/stash/show_prop'
    end

    def show_client
      fb_instance_id = Rails.application.secrets.fb_instance_id
      base_uri = "https://#{fb_instance_id}.firebaseio.com/"
      firebase = Firebase::Client.new(base_uri)
      @client_key = params["client_id"]
      response = firebase.get("props/" + @client_key )

      @props_hash = response.body
      # byebug
      # push("todos", { :name => 'Pick the milk', :priority => 1 })
      # response.success? # => true
      # response.code # => 200
      # response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
      # response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'

      render 'property_web_scraper/stash/show_client'
    end

    def index
      fb_instance_id = Rails.application.secrets.fb_instance_id
      base_uri = "https://#{fb_instance_id}.firebaseio.com/"
      firebase = Firebase::Client.new(base_uri)

      response = firebase.get("props")

      @clients_hash = response.body || {}
      # byebug
      # push("todos", { :name => 'Pick the milk', :priority => 1 })
      response.success? # => true
      response.code # => 200
      response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
      response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'
      # redirect_to "/scrapers/#{scraper_name}"
      render 'property_web_scraper/stash/index'
    end

    private


  end
end
