require 'time'

class TopController < ApplicationController
  def index
    time_now = Time.now
    time_yesterday = time_now - 24*60*60
    time_2daysago = time_now - 24*60*60*2
    time_week_from = time_now - 24*60*60*7
    time_week_to = time_now + 24*60*60

    # @all_articles = Article.all
    #   .order("date DESC")
    #   .limit(50)

    @daily_articles = Article.where(date: time_yesterday..time_now)
      .order("date DESC")
      .limit(50)

    @yesterday_articles = Article.where(date: time_2daysago..time_yesterday)
      .order("date DESC")
      .limit(50)

    @weekly_articles = Article.where(date: time_week_from..time_week_to)
      .order("date DESC")
      .limit(50)

  end

end
