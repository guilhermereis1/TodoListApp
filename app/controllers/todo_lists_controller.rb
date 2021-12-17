class TodoListsController < ApplicationController
  before_action :set_todo_list, only: %i[ show edit update destroy ]
  before_action :set_todo_list_items, only: %i[ show ]
  before_action :authenticate_user!

  # GET /todo_lists or /todo_lists.json
  def index
    @todo_lists = TodoList.where(user_id: current_user.id)
  end

  # GET /todo_lists/1 or /todo_lists/1.json
  def show
    @todo_list_item = TodoListItem.new
  end

  # GET /todo_lists/new
  def new
    @todo_list = TodoList.new
  end

  # GET /todo_lists/1/edit
  def edit
  end

  # POST /todo_lists or /todo_lists.json
  def create
    @todo_list = TodoList.new(todo_list_params)
    @todo_list.user_id = current_user.id

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to @todo_list, notice: "Todo list was successfully created." }
        format.json { render :show, status: :created, location: @todo_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_lists/1 or /todo_lists/1.json
  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to @todo_list, notice: "Todo list was successfully updated." }
        format.json { render :show, status: :ok, location: @todo_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_lists/1 or /todo_lists/1.json
  def destroy
    @todo_list.destroy
    respond_to do |format|
      format.html { redirect_to todo_lists_url, notice: "Todo list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    def set_todo_list_items
      @todo_list_items = TodoListItem.where(todo_list_id: params[:id]).order(created_at: :asc)
      @todo_list_items_done = @todo_list_items.where(completed: true)
      @todo_list_items_not_done = @todo_list_items.where(completed: false)
      @todo_list_items_count = @todo_list_items.count

      @todo_list_items_count.zero? ? @percentage_complete = 0.0 : @percentage_complete = (@todo_list_items_done.count / @todo_list_items_count.to_f * 100).round(0)
    end

    # Only allow a list of trusted parameters through.
    def todo_list_params
      params.require(:todo_list).permit(:name)
    end
end
