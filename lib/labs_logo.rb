require 'sinatra/base'
require 'tilt/erubis'
require 'json'

require_relative 'labs_logo/racks'
require_relative 'labs_logo/helpers'

module LabsLogo
  class App < Sinatra::Base
    helpers do
      include LabsLogo::Helpers
    end

    get '/' do
      redirect '/logo'
    end

    get '/logo' do
      num = rand(1..8)
      image = "/assets/odilabs-#{num}.svg"

      respond_to do |wants|
        wants.html do
          erb :index, layout: :default
        end

        wants.svg do
          redirect image
        end

        wants.json do
          {
            logo: image
          }.to_json
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
