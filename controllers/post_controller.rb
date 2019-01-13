class PostController <Sinatra::Base

    set :root, File.join(File.dirname(__FILE__), "..")

    set :view, Proc.new { File.join(root, "views") }

  configure:development do
    register Sinatra::Reloader
  end

  get "/" do
    #instance variable for my post controller class
    @title_for_the_page = "Books Posts"
    @books = Book.all
    erb :'books/index'
  end

  get "/new" do
    @books = Book.new
  erb:'books/new'
end

# #dynamic route
get "/:id_from_url" do
  id = params[:id_from_url].to_i
  @books = Book.find id
  erb :"books/show"

end

get "/:id/edit" do
      id = params[:id].to_i
      # @post = $posts[id]
    @books = Book.find id
      erb :"books/edit"
  end

  put '/:id' do
    id = params[:id].to_i
    books = Book.find id
    books.author = params[:author]
    books.description = params[:description]
    books.save
    redirect "/"
  end

  delete "/:id" do
      id = params[:id].to_i
      Book.destroy id
      redirect "/"
    end


post '/' do
books = Post.new
books.author = params[:author]
books.description = params[:description]
books.save
redirect "/"

end
end
