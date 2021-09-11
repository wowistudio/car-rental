module Authentication
  extend ActiveSupport::Concern

  MemberUnknown = Class.new(StandardError)

  included do
    before_action :authenticate

    rescue_from MemberUnknown, with: :render_error_response
  end

  private

  attr_reader :member

  def authenticate
    raise MemberUnknown if member_id.blank?

    @member = Member.find_by(uid: member_id)
  end

  def member_id
    request.headers['X-Member-Id']
  end

  def render_error_response(_error)
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end
