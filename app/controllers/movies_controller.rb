# movies controller
class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :destroy, :new]

  def search
    if params[:search]
      @movies = Movie.search(params[:search])
    else
      @movies = Movie.all
    end
  end

  def index
    @movies = Movie.all
  end

  def show
    @reviews = @movie.reviews.order('created_at DESC')
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  def new
    @movie = current_user.movies.build
  end

  def edit
  end

  def create
    @movie = current_user.movies.build(movie_params)
    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_path(@movie), notice: 'Movie was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_path(@movie), notice: 'Movie was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
    end
  end
  

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description,
                                  :movie_length, :director, :rating, :image)
  end
end
