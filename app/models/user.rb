class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workouts, dependent: :destroy

  def self.create_guest!
    user = create!(
      email: "guest-#{SecureRandom.hex(8)}@example.com",
      password: SecureRandom.hex(16),
      guest: true
    )
    user.seed_demo_data!
    user
  end

  def seed_demo_data!
    workout = workouts.create!(name: "Push Day", date: Date.today)

    {
      "Bench Press" => [[10, 95], [8, 105], [6, 115]],
      "Overhead Press" => [[10, 55], [8, 60]]
    }.each do |exercise_name, sets|
      exercise = Exercise.find_by(name: exercise_name)
      next unless exercise

      entry = workout.exercise_entries.create!(exercise: exercise)
      sets.each_with_index do |(reps, weight), index|
        entry.set_entries.create!(set_number: index + 1, reps: reps, weight: weight)
      end
    end
  end
end
