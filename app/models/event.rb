class Event < ApplicationRecord

  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :user

  validates :start_date,
  presence: true
  validate :event_past

  validates :duration,
  presence: true,:numericality => { :greater_than_or_equal_to => 1}
  validate :valid_duration

  validates :title,
  presence: true,
  length: { in: 5..140 }
  
  validates :description,
  presence: true,
  length: { in: 20..1000 }

  validates :price,
  presence: true,
  inclusion: 1..1000

  validates :location,
  presence: true

  private
  def event_past
   
    if start_date < DateTime.now
      errors.add(:start_date, "La date de départ de l'event ne peut pas etre dans le passé")
    end
  end

  def valid_duration
    if (self.duration % 5) != 0
      self.errors[:base] << "Number must be divisible by 5!"
    end
      
  end

  def self.showall
      events_array = Event.all					
      return events_array   		
    end








end
