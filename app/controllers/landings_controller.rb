class LandingsController < ApplicationController
  layout 'landing', only: :index

  def index
    @body = Setting.landing.value
  end

  def new
    @body = Setting.landing.value
  end

  def create
    landing = Setting.landing
    if landing.update(value: params[:body].html_safe)
      redirect_to :back, notice: 'Страница была успешно сохранена'
    end
  end
end
