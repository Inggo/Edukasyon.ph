class CreateCourseProfessorJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :professors, :courses do |t|
      # t.index [:professor_id, :course_id]
      t.index [:course_id, :professor_id], unique: true
    end
  end
end
