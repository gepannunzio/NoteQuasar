class TagsController < ApplicationController

  def index
    @tags = Tag.all.order(name: :asc)
  end

  def new
    @tag = Tag.new
  end

  def edit
    tag
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to new_note_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
    
  end


  def update

    if tag.update(tag_params)
      redirect_to tags_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
 
  end


  def destroy
    tag.destroy

    redirect_to tags_url, notice: t('.destroyed')
    
  end

  private
  def tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :user_id)
  end
end
