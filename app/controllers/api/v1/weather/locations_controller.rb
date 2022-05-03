# frozen_string_literal: true

module Api
  module V1
    module Weather
      class LocationsController < Api::V1::BaseController
        def regions
          response = ::Weather::HttpHelper.new(
            endpoint: '/locations/v1/regions?', params: region_params
          ).get

          render json: response
        end

        def countries
          response = ::Weather::HttpHelper.new(
            endpoint: "/locations/v1/countries/#{country_params[:region_code]}?"
          ).get

          render json: response
        end

        def areas
          response = ::Weather::HttpHelper.new(
            endpoint: "/locations/v1/adminareas/#{area_params[:country_code]}?"
          ).get

          render json: response
        end

        private

        def region_params
          params.permit(:language)
        end

        def country_params
          params.permit(:region_code).tap do |hash|
            hash[:region_code] = hash.require(:region_code)
          end
        end

        def area_params
          params.permit(:country_code).tap do |hash|
            hash[:country_code] = hash.require(:country_code)
          end
        end
      end
    end
  end
end
