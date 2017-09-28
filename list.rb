require_relative 'task'

class List
    attr_reader :title, :tasks

    def initialize(title, tasks = [])
        if tasks
            tasks.each do |task|
                if task.class != Task
                    raise ArgumentError
                end
            end
        end

        @title = title
        @tasks = tasks
    end

    def add_task(task)
        if task.class != Task
            return false
        else
            tasks << task
            return true
        end
    end

    def complete_task(index)
        if index_valid?(index)
            tasks[index].complete!
            return true
        else
            return false
        end
    end

    def delete_task(index)
        if index_valid?(index)
            tasks.delete_at(index)
            return true
        else
            return false
        end
    end

    def completed_tasks
        tasks.select {|task| task.complete?}
    end

    def incomplete_tasks
        tasks.select {|task| !task.complete?}
    end

    private

    def index_valid?(index)

        unless index.is_a? Integer
            raise ArgumentError
        end

        unless self.tasks.empty?
            if index >= 0 and index <= self.tasks.length
                return true
            else
                return false
            end
        else
            return false
        end
    end

end

list = List.new('test')
# list.add_task(Task.new('task desc'))
puts Task.new('sadf').class == Task
