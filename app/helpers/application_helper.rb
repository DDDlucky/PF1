module ApplicationHelper
  def page_title
    title = "エンジニアのための良書"
    title = @page_title + " - " + title if @page_title
    title
  end
end
