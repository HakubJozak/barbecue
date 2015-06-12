Barbecue::Dsl.scaffold do
  # adds migrations and Image,Video models
  uses :media_items
  uses :media_placements

  model :project do
    translated :title
    translated :meta_title
    translated :perex
    translated :content
    string :slug
    has_images :screenshots

    acts_as_list
  end

  # model :person do
  #   string :first_name
  #   string :last_name
  #   string :email
  #   string :phone
  #   translated bio
  #   has_image :portrait
  #   string :slug
  # end

  # model :article do
  #   translated :title
  #   translated :meta_title
  #   translated :perex
  #   translated :content
  #   datetime published_at
  #   has_image :image
  #   string :slug
  # end
end
