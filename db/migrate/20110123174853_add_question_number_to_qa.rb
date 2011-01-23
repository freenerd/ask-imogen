class AddQuestionNumberToQa < ActiveRecord::Migration
  def self.up
    add_column :qas, :question_number, :integer
  end

  def self.down
    remove_column :qas, :question_number
  end
end
