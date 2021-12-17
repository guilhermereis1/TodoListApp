class TodoListItemsController < ApplicationController
  before_action :set_todo_list_item, only: %i[ show edit update destroy update_status_task ]
  before_action :set_todo_list_id, only: %i[ show edit update destroy update_status_task ]
  before_action :set_redirect_path, only: %i[ update create ]
  before_action :authenticate_user!

  def index
    @todo_list_items = TodoListItem.all
  end

  def show
  end

  def new
    @todo_list_item = TodoListItem.new
  end

  def edit
  end

  def create
    @todo_list_item = TodoListItem.new(todo_list_item_params)

    respond_to do |format|
      if @todo_list_item.save
        format.html { redirect_to @redirect_path, notice: I18n.t('views.todo_list.show.notices.created') }
        format.json { render :show, status: :created, location: @todo_list_item }
      else
        format.html { redirect_to @redirect_path }
      end
    end
  end

  def update
    respond_to do |format|
      if @todo_list_item.update(todo_list_item_params)
        format.html { redirect_to @redirect_path, notice: I18n.t('views.todo_list.show.notices.updated') }
        format.json { render :show, status: :ok, location: @todo_list_item }
      else
        format.html { redirect_to @redirect_path }
      end
    end
  end

  def update_status_task
    respond_to do |format|
      if @todo_list_item.update(completed: !@todo_list_item.completed)
        message_congrats = @todo_list_item.completed ? I18n.t('views.todo_list.show.status_task.congrats', phrase: generate_phrase) : I18n.t('views.todo_list.show.status_task.shame', phrase: generate_phrase)

        if @todo_list_item.completed
          create_event(
            @todo_list_item.todo_list.user_id,
            'Congratulations', 
            @todo_list_item, 
            { 
              type: 'Congratulations', 
              phrase: I18n.t('views.todo_list.show.status_task.congrats', 
              phrase: generate_phrase), 
              color: @selected_color 
            }
          )
        else
          create_event(
            @todo_list_item.todo_list.user_id,
            'Shame', 
            @todo_list_item, 
            { 
              type: 'Shame', 
              phrase: I18n.t('views.todo_list.show.status_task.shame', 
              phrase: generate_phrase), 
              color: @selected_color 
            }
          )
        end

        format.html { redirect_to todo_list_path(@todo_list_id), notice: message_congrats }
        format.json { render :show, status: :ok, location: @todo_list_item }
      else
        format.html { redirect_to @redirect_path }
      end
    end
  end

  def destroy
    @todo_list_item.destroy
    respond_to do |format|
      format.html { redirect_to todo_list_path(@todo_list_id), notice: I18n.t('views.todo_list.show.notices.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    def set_todo_list_item
      @todo_list_item = TodoListItem.find(params[:id])
    end

    def create_event(user_id, event_type, item, properties)
      event = Event.create(
        user_id: user_id,
        name: {
          item_name: item.name, 
          item_id: item.id 
        },
        event_type: event_type, 
        properties: properties
      )
    end

    def set_todo_list_id
      @todo_list_id = @todo_list_item.todo_list_id
    end

    def set_redirect_path
      @redirect_path = todo_list_path(todo_list_item_params[:todo_list_id])
    end

    def generate_phrase
      phrase = []
      (1..5).each do |i|
        phrase << Faker::Lorem.sentence(word_count: 3)
      end
      phrase.join(" ")
    end

    def todo_list_item_params
      params.require(:todo_list_item).permit(:name, :completed, :todo_list_id)
    end
end