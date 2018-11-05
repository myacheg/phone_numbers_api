class NumbersController < ApplicationController
  respond_to :json

  def new
    @phone_number = CreateNumberService.call(number_params)

    respond_to do |format|
      format.json do
        render json: { user_name: phone_number.user_name, number: Number.stringified(phone_number.number) }
      end
    end
  end

  private

  attr_reader :phone_number

  def number_params
    params.permit(:number, :user_name)
  end
end
