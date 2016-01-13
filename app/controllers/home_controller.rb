class HomeController < ApplicationController
  def index
    match_pattern = /^[1-9]([0-9]*)?$/
    @from = params[:from]
    @to = params[:to]
    @secret = params[:secret] || "68afc34d981f1a94056757e32f20b9c6"
    audience = params[:audience]

    if @from && @to
      if @from =~ match_pattern && @to =~ match_pattern
        if @from.to_i > @to.to_i
          @action = "NOTHING"
        else
          @action = "MULTIPLE"
          cookies[:__audience] = @from
        end
      else
        @action = "NOTHING"
      end
    else
      @action = "SINGLE"
      cookies[:__audience] = audience
    end
  end

  def refresh
    cookies.clear
    @from = params[:from]
    @to = params[:to]
    redirect_to root_path(from: @from, to: @to)
  end
end
