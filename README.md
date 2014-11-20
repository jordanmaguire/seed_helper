# SeedHelper

SeedHelper is a small gem I created while I was working on various projects with terrible Seed files.

## Purpose

The goal of SeedHelper is to provide some commonly required functionality to make creating Seed files easier.

## Dependencies

SeedHelper uses the [colored](https://github.com/defunkt/colored) gem to present output.

## Example: Seed implementation

I use rake tasks to create my seed data. That way you can easily run individual tasks for seeding specific pieces of data.

Using SeedHelper, a seed task might look like:

```ruby
# in lib/tasks/seeds/create_roles.rake

SeedHelper.create_seed_task(:create_roles) do

  ["Admin", "Regular"].each do |role_name|

    # Will print out a red message if Role fails to save
    # Will print out a green message is Role succesfully creates
    # Will print out a cyan message if Role already exists
    role = SeedHelper.create_resource(Role, {name: role_name})

  end

end

# in lib/tasks/seeds/create_users.rake

include SeedHelper

# Specify a dependency on roles, so that running this task will first
# run the create_roles task
SeedHelper.create_seed_task(:create_users, [:create_roles]) do

  [
    ["admin@example.com", Role.admin],
    ["other_role@example.com", Role.other]
  ].each do |email, role_name|

    role = Role.find_by(name: role_name)
    admin = SeedHelper.find_or_create_resource(User, {email: email, role: role_name})

  end

end
```

## Example: Output

SeedHelper provides multiple methods for showing output that can be used outside of the `create_resource` method:

- `message` A general purpose message, generally used as a header. White by default.
- `success` Indicates a seed function was successful. Green by default.
- `error` Indicates a seed function has failed. Red by default.
- `resource_already_exists` Indicates that the data already exists in the database.
- `special_message` Show a purple multiline message. I use this to show logins for seed users.
