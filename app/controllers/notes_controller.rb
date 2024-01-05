class NotesController < ApplicationController

    def index 
        @notes = Note.all.order(created_at: :desc)
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
        note
    end

    def update 
        if note.update(note_params)
            redirect_to notes_path, notice: t('.updated')
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy 
        note.destroy

        redirect_to notes_path, notice: t('.destroyed'), status: :see_other
    end

    private 

    def note_params
        params.require(:note).permit(:title, :body, tag_id: [])
    end

    def note 
        @note = Note.find(params[:id])
    end

end