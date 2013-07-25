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

  def collect_links(c)

    links = []

    if c.main_website
      links << link_to("WEBSITE", c.main_website, :target => "_blank")
    end

    if c.blog
      links << link_to("BLOG", c.blog, :target => "_blank")
    end

    if c.email
      links << link_to("EMAIL", "mailto:"+c.email)
    end

    links.join(" &middot; ")
  end
end
