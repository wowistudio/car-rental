class V1::RentalsController < ApplicationController
  include Authentication

  def rent
    render_json(
      message: 'Vehicle rented',
      data: Rentals::Service::RentVehicle.new(member, permitted_params).call
    )
  end

  def return
    render_json(
      message: 'Vehicle returned',
      data: Rentals::Service::ReturnVehicle.new(member).call
    )
  end

  private

  def permitted_params
    params.require(:vehicle).permit(:id, :hours)
  end
end
