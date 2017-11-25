class Note < ApplicationRecord
  attr_accessor :remind_at_utc

  belongs_to :user

  scope :not_sent, -> { where(is_sent: false) }
  scope :need_reminded, -> { where('remind_at <= ?', Time.current) }

  before_create :set_remind_at

  validates :body, presence: true, length: { minimum: 2, maximum: 255 }
  validates :remind_at_utc, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}\z/ }
  validate  :remind_at_on_after_current_timestamp_validate

  def self.remind!
    is_sent_ids = []
    ios_notificator = IosPushNotificator.new

    not_sent.need_reminded.joins(:user).where(users: { device_type: 'ios' }).find_each do |note|
      ios_notificator.notify(note.user.device_token, note.body)
      is_sent_ids << note.id
    end

    Note.where(id: is_sent_ids).update_all(is_sent: true)
  end

  private

  def remind_at_on_after_current_timestamp_validate
    remind_at = convert_string_utc_to_datetime(remind_at_utc) rescue nil
    unless remind_at
      errors.add(:remind_at_utc, :invalid)
      return
    end

    unless remind_at >= Time.current
      errors.add(:remind_at_utc, :should_be_after_current_timestamp)
    end
  end

  def convert_string_utc_to_datetime(datetime_string)
    Time.zone.parse(datetime_string + ' UTC')
  end

  def set_remind_at
    self.remind_at = convert_string_utc_to_datetime(remind_at_utc)
  end
end
