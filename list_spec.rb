require "rspec"
require 'digest'

require_relative "task"
require_relative "list"

describe List do
  # Your specs here
    let(:title) { 'List Test' }
    let(:list) { List.new(title) }
    # let(:description1) { 'task1 description' }
    # let(:description2) { 'task2 description' }
    # let(:description3) { 'task3 description' }
    let(:task1) { Task.new( 'task1 description') }
    let(:task2) { Task.new( 'task2 description') }
    let(:task3) { Task.new( 'task3 description') }


    describe '#initialize' do
        it 'takes a title for its first argument' do
            expect(list).to be_a_kind_of(List)
        end

        it 'requires at least one argument' do
            expect{ List.new }.to raise_error(ArgumentError)
        end

        it 'should initialize with an array as a second argument' do
            expect(list.tasks).to be_a_kind_of(Array)
        end

        it 'should not accept other object in the array argument except Task' do
            expect{ List.new(title, [1, task1]) }.to raise_error(ArgumentError)
        end

    end

    describe '#add_task' do
        it 'should only accept a task object as argument' do
            expect(list.add_task(1)).to be(false)
        end

        it 'should be able to add a task to the tasks array' do

            expect(list.add_task(task1)).to be(true)
        end
    end

    describe '#complete_task' do

        it 'should requires 1 argument' do
            expect{ list.complete_task }.to raise_error(ArgumentError)
        end

        it 'should only take integer as argument' do
            list.add_task(task1)
            expect{ list.complete_task('1') }.to raise_error ArgumentError
        end

        it 'should change task status to completed' do
            list.add_task(Task.new('safsdf'))
            list.complete_task(0)
            expect(list.tasks[0].complete?).to be(true)
        end
    end

    describe '#delete_task' do
        it 'should delete the correct task' do
            list.add_task(task1)
            list.add_task(task2)
            list.add_task(task3)

            index = 2

            task1_hash = Digest::SHA256.digest(index.to_s + list.tasks[index].description)

            list.delete_task(index)

            valid = true

            list.tasks.each_with_index do |task, ind|
                if Digest::SHA256.digest(ind.to_s + task.description) == task1_hash
                    valid = false
                end
                break if valid == false
            end

            expect(valid).to be(true)
        end
    end

    describe '#completed_tasks' do

        it 'should return an array of tasks' do
            list.add_task(task1)
            list.complete_task(0)
            expect(list.completed_tasks).to be_a_kind_of(Array)
        end

        it 'should return the completed task' do
            list.add_task(task1)
            list.add_task(task2)
            list.complete_task(1)

            result = list.completed_tasks.select do |task|
                task.complete?
            end

            expect(result.length).to eq(1)
        end
    end

    describe '#incomplete_task' do
        it 'should return an array of tasks' do
            list.add_task(task1)
            list.complete_task(0)
            expect(list.completed_tasks).to be_a_kind_of(Array)
        end

        it 'should return the incompleted task' do
            list.add_task(task1)
            list.add_task(task2)
            list.add_task(task3)

            list.complete_task(1)

            result = list.incomplete_tasks.select do |task|
                !task.complete?
            end

            expect(result.length).to eq(2)
        end

    end
end