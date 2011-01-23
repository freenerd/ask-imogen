class CreateReservedQuestionNumbers < ActiveRecord::Migration
  def self.up
    create_table :reserved_question_numbers do |t|
      t.integer :question_number

      t.timestamps
    end
  end

  def self.down
    drop_table :reserved_question_numbers
  end
end
