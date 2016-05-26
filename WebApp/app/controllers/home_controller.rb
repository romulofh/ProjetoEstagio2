require 'rss'
require 'open-uri'

class HomeController < ApplicationController

  def welcome

  end

  def index

    if current_user == nil
      redirect_to root_url
    else
      user_id = current_user.id
      @preference_category = PreferenceCategory.find_by_user_id(params[user_id])

      @feeds = Array.new
      @categories = Array.new
      @rss = Array.new
      @source = Array.new
      @i

      @preference_category = PreferenceCategory.find_by(user_id: user_id)
      @preference_source = PreferenceSource.find_by(user_id: user_id)

      #Criando um array de source
      if @preference_source != nil and @preference_category != nil
        @preference_source.source_name.split.each do |ps|
          @source << ps
        end
      #Criando um array de category
        @preference_category.category_name.split.each do |pc|
          @categories << pc
        end
      else
        redirect_to root_path
      end
      @source.each do |s|
        @categories.each do |c|
            aux =  Feed.find_by(source_name: s.gsub(/[^0-9A-Za-z]/, ''), category_name: c.gsub(/[^0-9A-Za-z]/, ''))
          unless aux.nil?
            @feeds << aux
          end
        end
      end

      @feeds.each do |f|
        @rss << RSS::Parser.parse(f.url.delete(' '), false)
      end
  end
end

  def show
  end
end
