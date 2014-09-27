module SeedHelper::RakeHelper

  def self.create_seed_task(task_name, dependencies=[], &task)
    namespace :db do
      namespace :seed do
        desc "Creating #{task_name.to_s.humanize}"
        task task_name => dependencies.append(:environment) do
          message task_name.to_s.humanize

          task.call

          # Print a new line between each set of output for clarity
          puts ""
        end
      end
    end
  end

end