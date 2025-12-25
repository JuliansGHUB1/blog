json.extract! blog_post, :id, :title, :body, :banner_image, :tags, :created_at, :updated_at
json.url blog_post_url(blog_post, format: :json)
json.body blog_post.body.to_s
json.banner_image url_for(blog_post.banner_image)
