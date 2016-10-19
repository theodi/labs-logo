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
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @content = '<h1>Hello from LabsLogo</h1>'
          @title = 'LabsLogo'
          erb :index, layout: :default
        end

        wants.json do
          {
            app: 'LabsLogo'
          }.to_json
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end