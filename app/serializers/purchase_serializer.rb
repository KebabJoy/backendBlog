# frozen_string_literal: true

class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :title, :amount
end