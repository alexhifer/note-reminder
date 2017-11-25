class NoteReminderWorker
  include Sidekiq::Worker

  def perform(*args)
    Note.remind!
  end
end
