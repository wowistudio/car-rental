class V1::RentalsController < ApplicationController
  include Authentication

  def rent
    render_json(
      message: 'Vehicle rented',
      data: Rentals::Service::RentVehicle.new(member, rent_params).call
    )
  rescue Rentals::Service::RentVehicle::NeedsPledge
    render_json(message: 'Vehicle reserved. Pledge pending')
  rescue Rentals::Service::RentVehicle::HasCurrentRentals
    render_error(error: 'Has unfinished rentals')
  end

  def pledge
    render_json(
      message: 'Pledge added',
      data: Payments::Service::AddPledge.new(member, pledge_params).call
    )
  rescue Payments::Service::AddPledge::NoPendingPledge
    render_error(error: 'No rentals with state: pledging')
  rescue Payments::Cash::Service::AddPledge::UnsupportedAmount
    render_error(error: 'Unsupported amount')
  end

  def return
    render_json(
      message: 'Vehicle returned',
      data: Rentals::Service::ReturnVehicle.new(member, return_vehicle_params).call
    )
  rescue Rentals::Service::ReturnVehicle::NoCurrentRented
    render_error(error: 'No rentals with state: rented')
  end

  def pay
    render_json(
      message: 'Vehicle payment updated',
      data: Payments::Service::UpdatePaymentBalance.new(member, payment_params).call
    )
  rescue Payments::Service::UpdatePaymentBalance::NoPendingPayment
    render_error(error: 'No rentals with state: payment')
  rescue Payments::Cash::Service::UpdatePaymentBalance::UnsupportedAmount
    render_error(error: 'Unsupported amount')
  end

  def cashback
    render_json(
      message: 'Cash returned',
      data: Payments::Cash::Service::ReturnChange.new(member).call
    )
  rescue Payments::Cash::Service::ReturnChange::NoPendingCashback
    render_error(error: 'No rentals with state: cashback')
  end

  private

  def rent_params
    params.require(:vehicle).permit(:uid, :hours)
  end

  def pledge_params
    params.require(:pledge).permit(:payment_method, :amount)
  end

  def return_vehicle_params
    params.require(:vehicle).permit(:return_at)
  end

  def payment_params
    params.require(:payment).permit(:payment_method, :amount)
  end
end
