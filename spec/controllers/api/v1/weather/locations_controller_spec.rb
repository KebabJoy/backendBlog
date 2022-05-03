# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Weather::LocationsController, type: :controller do
  describe 'GET #regions' do
    before { get :regions }

    it 'returns list of locations' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #countries' do
    before { get :countries, params: { region_code: 'AFR' } }

    it 'returns list of locations' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #areas' do
    before { get :areas, params: { country_code: 'RU' } }

    it 'returns list of locations' do
      expect(response).to have_http_status(:ok)
    end
  end
end
