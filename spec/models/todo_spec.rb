require "rails_helper"

RSpec.describe Todo, type: :model do
  describe "validations" do
    it "allows a blank title" do
      todo = Todo.new(title: "")

      expect(todo).to be_valid
    end

    it "is invalid when title is longer than 100 characters" do
      todo = Todo.new(title: "a" * 101)

      expect(todo).not_to be_valid
      expect(todo.errors[:title]).to be_present
    end
  end
end
