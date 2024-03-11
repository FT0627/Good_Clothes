class Admin::ColorsController < ApplicationController
  before_action :authenticate_admin!
end
