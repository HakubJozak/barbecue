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
    text     :cv, translated: true
    integer  :position
    boolean  :happy
    decimal  :weight
    datetime :arrived_at
    images :wildlife_photos
  end 
```

And run the Blueprint generator:

    rails generate barbecue:blueprint --rebuild-db

Run `foreman start` and behold the admin interface.


## TODO

- merge with Shle under a `blueprint` project

## License

This project uses MIT-LICENSE.
