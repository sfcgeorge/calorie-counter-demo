class PagesController < ActionController::API
  skip_before_action :authenticate!, only: [:index]

  def index
    render
  end
end
