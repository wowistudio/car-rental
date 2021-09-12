class ApplicationController < ActionController::API
  def render_json(message:, data: {})
    render json: { message: message, datetime: Time.current, data: data }, status: :ok
  end

  def render_error(error)
    render json: error, status: :ok
  end
end
