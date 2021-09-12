class ApplicationController < ActionController::API
  def render_json(message:, data: {})
    render json: { message: message, data: data, datetime: Time.current }, status: :ok
  end

  def render_error(error)
    render json: error, status: :ok
  end
end
