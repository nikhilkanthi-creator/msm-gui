class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
  #create new record in movie table

  movie = Movie.new

  #retrieve user inputs from params,   #populate each column with input

  movie.title = params.fetch("the_title")
  movie.year = params.fetch("the_year")
  movie.description = params.fetch("the_description")
  movie.image = params.fetch("the_image")
  movie.director_id = params.fetch("the_director_id")
  movie.save
  #save

  #redirect

  redirect_to("/movies")
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_records = Movie.where({ :id => the_id}).at(0)
    matching_records.destroy
    redirect_to("/movies")
  end

end
