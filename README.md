# SeedHelper

SeedHelper is a small gem I created while I was working on various projects with terrible Seed files.

## Purpose

The goal of SeedHelper is to provide some commonly required functionality to make creating Seed files easier.

## Dependencies

SeedHelper uses the [colorize](https://github.com/fazibear/colorize) gem to present output.

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
    SeedHelper.find_or_create_resource(Role, {name: role_name})

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

By default, the `.find_or_create_resource` method uses the hash you provide it to find a User with those attributes. It can then determine whether or not it needs to create a new User.

This becomes problematic when we have a lot of fields, since we don't want to try and identify a User by some of those fields - password, for example.

In that case, we can pass through a third argument of all those additional fields:

```ruby
SeedHelper.find_or_create_resource(User, {email: email}, {password: "password", role: role_name})
```

## Example: Using FactoryGirl for a single object

Sometimes you'll want to create an object using FactoryGirl. You can pass a block to `.find_or_create_resource` to achieve this. EG:

```ruby
SeedHelper.find_or_create_resource(User, {email: "admin@example.com"}, {password: "Alligator8"}) do |attributes|
  FactoryGirl.build(:user, :admin, :with_profile_picture, attributes)
end
```

This will return a User that matches {email: "admin@example.com"} (and print out a message saying the object already exists), or it will use the FG call to create a new object (and return a success message if the object returned is valid).

NB: You should return an unpersisted object in this block.

## Example: Using FactoryGirl for a collection of objects

If you don't want to provide specific attributes, you can use the `.bulk_create` function to do so. EG:

```ruby
# If MyClass.count > 0, an already created message will be shown
# If MyClass.count == 0, the block will be run
# If the block fails, you'll get a red error message with the exception printed out.
SeedHelper.bulk_create(MyClass) do
  FactoryGirl.create_list(:my_class, 5)
end
```

If you want to bulk create some associated objects for a given object, you can pass a hash of attributes to scope the `.bulk_create` by:

```ruby
Client.all.each do |client|
  SeedHelper.bulk_create(User, {client_id: client.id}) do |client_attributes|
    FactoryGirl.create_list(:user, 5, client_attributes)
  end
end
```

You can pass a custom message through:

```ruby
Client.all.each do |client|
  SeedHelper.bulk_create(User, {client_id: client.id}, "Users for #{client.name}") do |client_attributes|
    FactoryGirl.create_list(:user, 5, client_attributes)
  end
end

# Users for DeathCorp already exists
# Created Users for DeathCorp
# Failed to create Users for DeathCorp
```

## Example: Output

SeedHelper provides multiple methods for showing output that can be used outside of the `create_resource` method:

- `message` A general purpose message, generally used as a header. White by default.
- `success` Indicates a seed function was successful. Green by default.
- `error` Indicates a seed function has failed. Red by default.
- `resource_already_exists` Indicates that the data already exists in the database.
- `special_message` Show a purple multiline message. I use this to show logins for seed users.

## Example: Creating a rake task

SeedHelper gives you an easy way to create consistently named rake tasks. Usage is as follows:

```ruby
# rake db:seed:task_name
# :environment is automatically added as a dependency
SeedHelper.create_seed_task(:task_name)

# rake db:seed:second_task_name
# Dependent on :task_name, rake db:seed:task_name will be run before :second_task_name
SeedHelper.create_seed_task(:second_task_name, [:task_name])

# rake db:seed:third_task_name
# No dependencies (other than environment) but with a custom title. This will show up as
# description of task in `rake -T` and will be printed to screen when task runs
SeedHelper.create_seed_task(:third_task_name, [], "My sick name")
```
