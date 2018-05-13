require 'time'

class TopController < ApplicationController
  def articles
    user_agent_mobile_or_not = discriminate_user_agent_mobile_or_not
    if user_agent_mobile_or_not == "mobile"
      @access_from_mobile = true
    else
      @access_from_mobile = false
    end
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
    if params[:display]
      case params[:display]
      when "list"
        @articles_display = "list"
      when "grid"
        @articles_display = "grid"
      else
        @articles_display = "list"
      end
    else
      @articles_display = "list"
    end

  end

  private

  def category_params
    params.require(:category)
  end

  def discriminate_user_agent_for_browser
    ua = request.user_agent
    if ua.include? "MSIE"
      browser = "ie"
    elsif ua.include? "Firefox"
      browser = "firefox"
    elsif ua.include? "Chrome"
      browser = "chrome"
    elsif ua.include? "Opera"
      browser = "opera"
    elsif ua.include? "safari"
      browser = "safari"
    else
      browser = "others"
    end
    return browser
  end

  def discriminate_user_agent_mobile_or_not
    ua = request.user_agent
    if(ua.include?('Mobile') || ua.include?('Android'))
      return  "mobile"
    else
      return "PersonalComputer"
    end
  end

end
