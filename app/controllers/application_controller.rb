class ApplicationController < ActionController::API
  def render_json(message:, data: {})
    render json: { message: message, data: data }, status: :ok
  end
end
