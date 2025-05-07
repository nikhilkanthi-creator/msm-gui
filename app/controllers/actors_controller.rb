class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create

    actor = Actor.new

    #retrieve user inputs from params,   #populate each column with input
  
    actor.name = params.fetch("the_name")
    actor.dob = params.fetch("the_dob")
    actor.bio = params.fetch("the_bio")
    actor.image = params.fetch("the_image")
    actor.save
    #save
  
    #redirect
  
    redirect_to("/actors")
  
  end

  def destroy

    the_id = params.fetch("an_id")
    matching_records = Actor.where({ :id => the_id}).at(0)
    matching_records.destroy
    redirect_to("/actors")

  end

  def update

  # get the id out of params
  actor_id = params.fetch("the_id")
  # look up the existing record
matching_actor = Actor.where({ :id => actor_id}).at(0)

  # overwrite each column with the values from user input, save
  matching_actor.name = params.fetch("the_name")
  matching_actor.dob = params.fetch("the_dob")
  matching_actor.bio = params.fetch("the_bio")
  matching_actor.image = params.fetch("the_image")
  matching_actor.save

redirect_to("/actors/#{matching_actor.id}")
# redirect to the same page (movie details)

  end

end
