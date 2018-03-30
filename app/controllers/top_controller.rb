require 'time'

class TopController < ApplicationController
  def articles
    time_now = Time.now
    time_yesterday = time_now - 24*60*60
    time_2daysago = time_now - 24*60*60*2
    time_week_from = time_now - 24*60*60*7
    time_week_to = time_now + 24*60*60
    if params[:category]
      case params[:category]
      when "column"
        @category_title = "コラム"
      when "it"
        @category_title = "IT"
      when "gourmet"
        @category_title = "グルメ"
      else
        @category_title = "ALL"
      end

      @daily_articles = Article.where(date: time_yesterday..time_now)
        .where("category = ?", category_params)
        .order("date DESC")
        .limit(50)
      @yesterday_articles = Article.where(date: time_2daysago..time_yesterday)
        .where("category = ?", category_params)
        .order("date DESC")
        .limit(50)
      # @weekly_articles = Article.where(date: time_week_from..time_week_to)
      #   .where("category = ?", category_params)
      #   .order("date DESC")
      #   .limit(50)
    else
      @category_title = "ALL"
      @daily_articles = Article.where(date: time_yesterday..time_now)
        .order("date DESC")
        .limit(50)

      @yesterday_articles = Article.where(date: time_2daysago..time_yesterday)
        .order("date DESC")
        .limit(50)

      # @weekly_articles = Article.where(date: time_week_from..time_week_to)
      #   .order("date DESC")
      #   .limit(50)
    end
  end

  private

  def category_params
    params.require(:category)
  end

end
