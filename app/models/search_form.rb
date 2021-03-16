class SearchForm
  include ActiveModel::Model

  attr_accessor :keyword

  # VALID_KEYWORD_REGEX = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/
  validates :keyword, presence: true, length: { in: 2..20 }
end
