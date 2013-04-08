module ApplicationHelper

  def dict(collection)
    collection.map { |v| [t("dict.#{v}"), v] }
  end
end
