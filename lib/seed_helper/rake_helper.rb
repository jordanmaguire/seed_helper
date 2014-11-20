require 'rake'

module SeedHelper::RakeHelper

  include Rake::DSL

  def create_seed_task(task_name, dependencies=[], title="", &task)
    namespace :db do
      namespace :seed do
        seed_title = title.empty? ? "Creating #{task_name.to_s.humanize}" : title
        desc(seed_title)
        task task_name => dependencies.append(:environment) do
          message(seed_title)

          task.call

          # Print a new line between each set of output for clarity
          puts ""
        end
      end
    end
  end

end