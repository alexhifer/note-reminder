module Api
  class V1::NotesController < BaseController
    acts_as_token_authentication_handler_for User

    # POST /api/v1/notes
    # @return JSON
    def create
      note = current_user.notes.build(note_params)

      if note.save
        render json: { status: 'success', data: note.as_json(only: %i(id remind_at)) }
      else
        render json: { status: 'error', error_messages: note.errors.messages }
      end
    end

    private

    def note_params
      params.permit(:body, :remind_at_utc)
    end
  end
end
