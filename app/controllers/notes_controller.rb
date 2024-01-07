class NotesController < ApplicationController    
    def index
        @tags = Tag.all.order(name: :asc).load_async
        @notes = Note.includes(:tags).order(created_at: :desc)
      
        # Filter by query text
        if params[:query_text].present?
          @notes = @notes.search_full_text(params[:query_text])
        end
      
        # Filter by archive
        if params[:archives].present?
          @notes = @notes.joins(:archives).where(archives: { user_id: Current.user.id })
        else
          @notes = @notes.left_joins(:archives).where(archives: { id: nil })
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

    def show 
        note
    end

    def new 
        @note = Note.new
    end

    def create 
        @note = Note.new(note_params)

        if @note.save 
            redirect_to notes_path, notice: t('.created')
        else 
            render :new, status: :unprocessable_entity
        end
    end

    def edit 
        authorize! note
    end

    def update
        authorize! note
        if note.update(note_params)
          redirect_to note_path(note), notice: t('.updated')
        else
          render :edit, status: :unprocessable_entity
        end
      end

    def destroy 
        authorize! note
        note.destroy

        redirect_path = if request.referer.present? && request.referer.include?("/archive")
                            archives_path
                        elsif request.referer.present? && request.referer.include?("/active")
                            notes_path
                        else
                            notes_path
                        end

        redirect_to redirect_path, alert: t('.destroyed'), status: :see_other
    end

    private 

    def note_params
        params.require(:note).permit(:title, :body, tag_ids: [])
    end

    def note_params_index
        params.permit(:query_text, :displayed_tag_ids, :page, :archives, :user_id)
    end
    def note 
        @note ||= Note.find(params[:id])
    end

end