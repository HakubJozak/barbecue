# Barbecue

Barbecue is a strongly opiniated set of Ember components and
Rails generators useful to quickly scaffold an almost
production ready administration interface for your models.

## Basic Usage

Use [shle](https://github.com/sinfin/shle) to generate a fresh Rails
application. Then sketch your models in `db/blueprint.rb` like this:

```ruby
  model :animal do
    string   :name, required: true
    string   :species, translated: true
    text     :bio, translated: true
    integer  :number_of_legs
    boolean  :happy
    decimal  :weight
    datetime :birth_date
    images :wildlife_photos
  end

  model :contact do
    string :first_name
    string :last_name
    string :email, required: true
    image  :portrait
  end
```

And run the Blueprint generator:

    rails generate barbecue:blueprint --rebuild-db

That will use a set of underlying generators to create an ActiveRecord model,
ActiveModel Serializer, RESTful controller for JSON API and UI frontend files
for Ember.js. 

Run `foreman start`, login (see `db/seed.rb' for password) and
behold the admin interface.


## TODO

- merge with Shle under a `blueprint` project

## License

This project uses MIT-LICENSE.
