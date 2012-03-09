class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort_val = ["title","release_date"].include?(params[:sort_by])?params[:sort_by] : nil;
    @ratings_val = (params[:ratings] != nil)? params[:ratings]: Hash.new;
    condition = (@ratings_val.keys.empty? == false)?["rating IN (?)", @ratings_val.keys] : nil;
    @movies = Movie.find(:all, :conditions => condition, :order => @sort_val)
    @all_ratings = Movie.all_ratings
  #  @all_ratings.each{|rating| logger.info(rating.rating)}
   # logger.info(@all_ratings)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  

end
