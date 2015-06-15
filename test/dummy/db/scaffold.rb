Barbecue::Dsl.scaffold do
  # adds migrations and Image,Video models
  # uses :media_items
  # uses :media_placements

  model :project do
    string :title, translated: true
    string :meta_title, translated: true
    string :perex
    string :content
    string :slug

    images :screenshots
    image :portrait

    position scope: :company
    slug :title
    # generates friendly_id :slug_candidates, use: slugged
    #
    # def slug_candidates
    #   [ :title_en, :title_cs ]?
    # end
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
