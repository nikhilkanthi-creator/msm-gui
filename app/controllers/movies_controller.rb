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

  def update
  # get the id out of params
  movie_id = params.fetch("the_id")
    # look up the existing record
  matching_movie = Movie.where({ :id => movie_id}).at(0)

    # overwrite each column with the values from user input, save
  matching_movie.title = params.fetch("the_title")
  matching_movie.year = params.fetch("the_year")
  matching_movie.description = params.fetch("the_description")
  matching_movie.image = params.fetch("the_image")
  matching_movie.director_id = params.fetch("the_director_id")
  matching_movie.save

  redirect_to("/movies/#{matching_movie.id}")
  # redirect to the same page (movie details)
  end


end
