class TodosController < ApplicationController
  def index
    #matching_todos = Todo.all
    matching_todos = Todo.where({ :user_id => session.fetch(:user_id)})
    @list_of_todos = matching_todos.order({ :created_at => :desc })
    @list_waiting_on = matching_todos.where({:status => "waiting_on"})
    @list_received = matching_todos.where({:status => "received"})

    render({ :template => "todos/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_todos = Todo.where({ :id => the_id })

    @the_todo = matching_todos.at(0)

    render({ :template => "todos/show.html.erb" })
  end

  def create
    the_todo = Todo.new
    the_todo.description = params.fetch("query_description")
    the_todo.date_to_arrive = params.fetch("query_date_to_arrive")
    the_todo.details = params.fetch("query_details")
    the_todo.status = "waiting_on"
    the_todo.user_id = session.fetch(:user_id)
    today = Date.today
    
    if the_todo.valid?
      the_todo.save
      redirect_to("/todos", { :notice => "Added to list." })
    else
      
      redirect_to("/", { :alert => the_todo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_todo = Todo.where({ :id => the_id }).at(0)

    #the_todo.description = params.fetch("query_description")
    
    the_todo.status = params.fetch("query_status")
    #the_todo.status = "received"
    the_todo.user_id = session.fetch(:user_id)
    #the_todo.save
      #redirect_to("/", { :notice => "Todo updated successfully."} )
    if the_todo.valid?
     the_todo.save
      redirect_to("/todos", { :notice => "Added to list"} )
    else
      redirect_to("/todos", { :alert => the_todo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_todo = Todo.where({ :id => the_id }).at(0)

    the_todo.destroy

    redirect_to("/", { :notice => "Todo deleted successfully."} )
  end
end
