
require 'rspec-given'
require "rspec"
require_relative "task"

describe Task do

  let(:description) { "Walk the giraffe" }
  let(:task)        { Task.new(description) }

  describe "#initialize" do
    it "takes a description for its first argument" do
      expect(Task.new("Feed the parakeet")).to be_a_kind_of(Task)
    end

    it "requires one argument" do
      expect { Task.new }.to raise_error(ArgumentError)
    end
  end

  describe "#description" do
    it "returns the correct description for the task" do
      expect(task.description).to eq description
    end
  end

  describe "#complete?" do
    it "returns false for incomplete tasks" do
      expect(task.complete?).to be(false)
    end

    it "returns true for completed tasks" do
      task.complete!
      expect(task.complete?).to be(true)
    end
  end

  describe "#complete!" do
    it "changes the task from incomplete to completed" do

      # This is some RSpec goodness which expects a
      # method `complete?` to be defined which returns
      # true or false.
      #
      expect(task).not_to be_complete
      task.complete!
      expect(task).to be_complete
    end
  end
end