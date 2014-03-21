# encoding: utf-8

class ApiController < ApplicationController
  def validate_key
    render :nothing=>true
  end
end
