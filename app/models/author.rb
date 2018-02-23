class Author < User
  #use update_columns to add type: "Author" in console
  has_many :articles

  has_many :recipes
end
