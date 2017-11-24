class User < ApplicationRecord
  DEVICE_TYPES = %w(ios android).freeze

  has_many :notes, dependent: :destroy

  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  validates :device_token, presence: true
  validates :device_type, presence: true, inclusion: { in: DEVICE_TYPES }
end
