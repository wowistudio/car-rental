class Monitoring::HealthController < ApplicationController
  def index
    render plain: '👍 All good'
  end
end
