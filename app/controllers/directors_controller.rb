class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
      #create new record in movie table

  director = Director.new

  #retrieve user inputs from params,   #populate each column with input

  director.name = params.fetch("the_name")
  director.dob = params.fetch("the_dob")
  director.bio = params.fetch("the_bio")
  director.image = params.fetch("the_image")
  director.save
  #save

  #redirect

  redirect_to("/directors")
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_records = Director.where({ :id => the_id}).at(0)
    matching_records.destroy
    redirect_to("/directors")

  end

  def update

  # get the id out of params
  director_id = params.fetch("the_id")
  # look up the existing record
matching_director = Director.where({ :id => director_id}).at(0)

  # overwrite each column with the values from user input, save
  matching_director.name = params.fetch("the_name")
  matching_director.dob = params.fetch("the_dob")
  matching_director.bio = params.fetch("the_bio")
  matching_director.image = params.fetch("the_image")
  matching_director.save

redirect_to("/directors/#{matching_director.id}")
# redirect to the same page (movie details)
  end

end
