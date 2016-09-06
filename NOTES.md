1. I want to have a bunch of blog posts
2. Be able to CRUD those posts

GET /posts -> show an index of all my blog posts
GET /posts/:id -> show a particular blog post by :id
GET /posts/new -> a form for new blog posts
POST /posts -> submitting the new blog posts
GET /posts/:id/edit -> editing a blog post

URLs
Routes
Controller Actions
Models
Database
Views

1. Plan out some URLs for the feature I'm building
2. Ask, does my database need to change? Yes, I need a new table.
3. If I need a new table, do I have that model? No, so use the model generator.
4. After I generate a new model and migrate my db, I want to play with it in console.

ActiveRecord Conventions:
Table name: lowercase plural name of model (posts)
Model filename: singular lowercase name of model snakecase (post.rb)
Class name: singular camelcase (Post)
Controller class name: plural camelcase + Controller (PostsController)
Controller filename: lowercase plural snakecase (posts_controller.rb)

A Rails route maps a URL to a Controller and Action
                              Class          Method

1. Create table (in terminal):
  rails generate migration
    => gives instructions on how to generate migration
2. `rails generate migration CreatePosts title:string`
3. generates a migration file, which you can add to if desired.
4. `rake db:migrate`
5. delete that migration
6. rm -rd db/development.sqlite3 (we're starting over from scratch)
7. `rails generate model` (gives instruction list)
  => includes generate migration
8. `rails generate model Post title:string content:text`
  => Running via Spring preloader in process 47455
      invoke  active_record
      create    db/migrate/20160906125022_create_posts.rb
      create    app/models/post.rb
      invoke    test_unit
      create      test/models/post_test.rb
      create      test/fixtures/posts.yml
9. `rake db:migrate`
10. `rails console`
11. `rails generate controller` gives you help for Controller
12. `rails generate controller PostsController`
  => Running via Spring preloader in process 47530
      create  app/controllers/posts_controller_controller.rb
      invoke  erb
      create    app/views/posts_controller
      invoke  test_unit
      create    test/controllers/posts_controller_controller_test.rb
      invoke  helper
      create    app/helpers/posts_controller_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/posts_controller.coffee
      invoke    scss
      create      app/assets/stylesheets/posts_controller.scss
13. `rails destroy controller PostsController`
  => Running via Spring preloader in process 47547
      remove  app/controllers/posts_controller_controller.rb
      invoke  erb
      remove    app/views/posts_controller
      invoke  test_unit
      remove    test/controllers/posts_controller_controller_test.rb
      invoke  helper
      remove    app/helpers/posts_controller_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      remove      app/assets/javascripts/posts_controller.coffee
      invoke    scss
      remove      app/assets/stylesheets/posts_controller.scss
14. `rails generate controller Posts`
  => Running via Spring preloader in process 47556
      create  app/controllers/posts_controller.rb
      invoke  erb
      create    app/views/posts
      invoke  test_unit
      create    test/controllers/posts_controller_test.rb
      invoke  helper
      create    app/helpers/posts_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/posts.coffee
      invoke    scss
      create      app/assets/stylesheets/posts.scss
15. test: In posts_controller.rb:
      def home
        render :plain => "Hello World"
      end
16. Go to config/routes.rb
17. Commented out are explanations and examples
18. Add to routes.rb:
      get({'/hello_world' => 'posts#home'})
      get '/posts' => 'posts#index'
19. Add to posts_controller.rb:
      def index
      end
20. Create file views/posts/index.html.erb
21. Add to routes.rb:
      get '/team' => 'static#team'
      get '/about' => 'static#about'
22. In terminal:
      `rails generate controller static about team`
      => Running via Spring preloader in process 48359
      create  app/controllers/static_controller.rb
       route  get 'static/team'
       route  get 'static/about'
      invoke  erb
      create    app/views/static
      create    app/views/static/about.html.erb
      create    app/views/static/team.html.erb
      invoke  test_unit
      create    test/controllers/static_controller_test.rb
      invoke  helper
      create    app/helpers/static_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/static.coffee
      invoke    scss
      create      app/assets/stylesheets/static.scss
23. In routes.rb delete routes created by rails generate:
        get 'static/about'
        get 'static/team'
24. In views folder, delete static/about.html.erb and static/team.html
25. Explicitly render views for these in StaticController
26. In static_controller.rb:
    render 'content/team' # <= add to def team
    render 'content/about' # <= add to def about
27. In views folder:
  Create folder "content"
  Create file "content/about.html.erb"
  Create file "content/team.html.erb"
28. In posts_controller.rb
  def index
    @posts = Post.all
  end
29. In views/posts/index.html.erb:
<% @posts.each do |post| %>
<ol>
  <li><%= post.title %></li>
</ol>
<% end %>
30. add to routes.rb:
  get '/posts/:id' => 'posts#show', as: :post
31. In terminal:
  rake routes
  =>
  Prefix Verb URI Pattern            Controller#Action
hello_world GET  /hello_world(.:format) posts#home
      posts GET  /posts(.:format)       posts#index
       post GET  /posts/:id(.:format)   posts#show
       team GET  /team(.:format)        static#team
      about GET  /about(.:format)       static#about
32. If your url has a variable (such as :id), the helper method to generate the route will accept an argument of that variable. For instance:
  app.post_path(1)
    => "/posts/1"
  OR you can do:
  p = Post.first
  app.post_path(p.id)
    => "/posts/1"
  OR best:
  app.post_path(p)
    => "/posts/1"
33. Make link in posts/index.html.erb
34. Don't even need to do: <%= link_to "<%= post.title %>", post_path(post) %>
      Can just do:
      <%= link_to(post.title, post_path(post)) %>


LINK_TO:

<%= link_to "About Us", "/about" %>
becomes in browser:
   => <a href="/about">About Us</a>
Even better way is :
<%= link_to "About Us", about_path %>

In rails console:
app.about_path will give you
  => "/about"

if you add "as: ", you can change the path name:

in routes.rb:
  get '/about' => 'static#about', as: :kerrys_cool_path
in view:
  <%= link_to "About Us", kerrys_cool_path %>
html stays:   
  <a href="/about">About Us</a>
rake routes shows:
  kerrys_cool_path GET /about static#about
