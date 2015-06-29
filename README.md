# Barbecue

Barbecue is a strongly opiniated set of Ember components and
Rails generators useful to quickly scaffold an almost
production ready administration interface for your models.

## Usage

Sketch your models in `db/blueprint.rb` like this:

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

    rails generate barbecue:blueprint --force --rebuild-db


This uses MIT-LICENSE.
