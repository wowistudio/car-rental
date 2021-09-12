class V1::RentalsController < ApplicationController
  include Authentication

  def rent
    render_json(
      message: 'Vehicle rented',
      data: Rentals::Service::RentVehicle.new(member, rent_params).call
    )
  end

  def return
    render_json(
      message: 'Vehicle returned',
      data: Rentals::Service::ReturnVehicle.new(member).call
    )
  end

  def pay
    render_json(
      message: 'Vehicle payment updated',
      data: Payments::Service::UpdatePaymentBalance.new(member, payment_params).call
    )
  end

  def cashback
    render_json(
      message: 'Cash returned',
      data: Payments::Cash::Service::ReturnChange.new(member).call
    )
  end

  private

  def rent_params
    params.require(:vehicle).permit(:uid, :hours)
  end

  def payment_params
    params.require(:payment).permit(:payment_method, :amount)
  end
end
