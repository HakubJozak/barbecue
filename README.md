# Barbecue

Barbecue is a strongly opiniated set of Ember components and
Rails generators useful to quickly scaffold an almost
production ready administration interface for your models.

## Usage

Sketch your models in `db/blueprint.rb`:

```ruby
  model :animal do
    string :title, translated: true
    images :wildlife_photos
  end 
```

Then run:

    rails generate barbecue:blueprint --force --rebuild-db


This uses MIT-LICENSE.
