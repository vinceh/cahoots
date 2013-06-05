module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def collect_links

    links = []

    if @s.main_website
      links << link_to("WEBSITE", @s.main_website, :target => "_blank")
    end

    if @s.blog
      links << link_to("BLOG", @s.blog, :target => "_blank")
    end

    if @s.email
      links << link_to("EMAIL", "mailto:"+@s.email)
    end

    links.join(" &middot; ")
  end
end
