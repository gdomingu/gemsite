require "sinatra"
require "sinatra/reloader"
require "movies"
require "stock_quote"
require "image_suckr"


get "/" do
	erb :index
end				

get "/movies" do

	@name = params[:name]
	unless @name.nil?
		begin
			@movietitle = Movies.find_by_title(@name).title
			@moviedirector = Movies.find_by_title(@name).director
			@movierating = Movies.find_by_title(@name).rating
			@movieyear = Movies.find_by_title(@name).year
			suckr = ImageSuckr::GoogleSuckr.new
			@img = suckr.get_image_url({"q" => @name})
			erb :movies
		rescue
			erb :index
			end
		end
	end	
	#@movieimg = suckr.get_image_url({"q" => @name})
	#This is where the movie image search is. 


get "/images" do

	@keyword = params[:keyword]
	unless @keyword.nil?
		begin
			suckr = ImageSuckr::GoogleSuckr.new
			@img = suckr.get_image_url({"q" => @keyword})
			erb :images
		rescue
			erb :index
			end	
		end
end

get "/randimg" do

	params[:random]
	suckr = ImageSuckr::GoogleSuckr.new
	@imgrand = suckr.get_image_url({"q" => @randkeyword})
	a = ["chincilla", "dog", "friend", "griffin", "Arya", "Dog", "cat", "Witcher", "potato", "ruby", "python", "lamp", "shinto", "unicorn", "tape", "beach", "ocean", "rain", "boots", "eye mask"]
	@randkeyword = a.sample

	erb :randimg
end
get "/stocks" do
	@symbol = params[:symbol]
	unless @symbol.nil?
		begin
			@company = StockQuote::Stock.quote(@symbol).company
			@stocksym = StockQuote::Stock.quote(@symbol).pretty_symbol
			@stocklast = StockQuote::Stock.quote(@symbol).last
			@stockhigh = StockQuote::Stock.quote(@symbol).high
			@stocklow = StockQuote::Stock.quote(@symbol).low
			suckr = ImageSuckr::GoogleSuckr.new
			@img = suckr.get_image_url({"q" => @symbol})
			erb :stocks
		rescue
			erb :index
		end
	else
		erb :index
	end
end


