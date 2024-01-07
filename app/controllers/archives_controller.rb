class ArchivesController < ApplicationController

  def index
    @tags = Tag.all.order(name: :asc).load_async
    @notes = Note.includes(:tags).order(created_at: :desc)
  
    # Filter by query text
    if params[:query_text].present?
      @notes = @notes.search_full_text(params[:query_text])
    end
  
    # Filter by archive
    if params[:archives].present? 
      @notes = @notes.left_joins(:archives).where(archives: { id: nil })
    else
      @notes = @notes.joins(:archives).where(archives: { user_id: Current.user.id })
    end
  
    # Keep track of displayed tag IDs
    @displayed_tag_ids = Array(params[:displayed_tag_ids]).map(&:to_i)
  
    # Filter by tag IDs
    if params[:tag_ids].present?
      new_tag_ids = params[:tag_ids].map(&:to_i) - @displayed_tag_ids
      @displayed_tag_ids += new_tag_ids
  
      # Use left join for tags and conditionally filter by tag IDs
      @notes = @notes.left_joins(:tags).where(tags: { id: new_tag_ids })
    end
  
    @user = User.find_by!(username: Current.user.username)
    @pagy, @notes = pagy_countless(@notes.where(user_id: @user.id).load_async, items: 12)
  end
  

    def create
      Archive.create(note: note, user: Current.user)
      note.archive!
      respond_to do |format|
        format.html do
          redirect_to note_path(note), notice: t('.created')
        end
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("archive", partial: "notes/archive", notice: t('.created'), locals: { note: note })
        end
      end
    end
  
    def destroy
      note.unarchive!
    
      respond_to do |format|
        format.html do
          redirect_to note_path(note), notice: t('.destroyed'), status: :see_other
        end
    
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("archive", partial: "notes/archive", locals: { note: note })
        end
      end
    end

    private
  
    def note
      @note ||= Note.find(params[:note_id])
    end
  end