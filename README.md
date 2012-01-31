# SeedFormatter

SeedFormatter is a small gem I created while I was working on various projects with terrible, terrible Seed files.

## Purpose

The goal of SeedFormatter is to provide some commonly required functionality to be used in Seed files.

## Dependencies

SeedFormatter uses the [colored](https://github.com/defunkt/colored) gem to present output.

## Example: Seed file layout

I like my seed files to follow this format:

```ruby
class Seed
  class << self
    def create_categories
      # create some categories here
    end

    def create_admin_user
      # create an admin user here
    end
  end  
end

Seed.create_categories
Seed.create_admin_user
```

I find this to be the neatest way to write Seed files.

## Example: Output

SeedFormatter provides four methods of putting output:

- `message`: A general purpose message, generally used as a header. White by default.
- `success`: Indicates a seed function was successful. Green by default.
- `error`: Indicates a seed function has failed. Red by default.
- `spacer`: Just to add a single space to separate groups of functionality.

Using these functions is straight forward (if we use the above example):

```ruby
class Seed
  class << self
    include SeedFormatter

    def create_categories
      message "Creating some categories"

      ["Sedan", "SUV", "Hatchback"].each do |category_name|
        category = Category.create :name => category_name        
        if category.valid?
          success "Created #{category_name}"
        else
          error "Failed to create #{category_name}. Errors: #{category.errors.full_messages}"
        end
      end

      spacer
    end
  end
end
```



