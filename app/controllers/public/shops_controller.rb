class Public::ShopsController < ApplicationController
  before_action :authenticate_user!, exept: [:index, :show]
end
