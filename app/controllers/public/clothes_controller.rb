class Public::ClothesController < ApplicationController
  before_action :authenticate_user!, except[:show]
end
