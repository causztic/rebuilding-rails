class QuotesController < Rulers::Controller
  def show
    @quote = FileModel.find(params["id"])
    ua = request.user_agent

    render_response :quote, ua: ua
  end

  def a_quote
    @noun = :winking
    render :a_quote
  end

  def index
    @quotes = FileModel.all
    render :index
  end

  def update_quote
    request = Rack::Request.new(env)
    
    if request.put?
      quote = FileModel.find(1)
      quote.save(request.params)

      "#{quote.to_json}"
    end
  end

  def new_quote
    attrs = {
      "submitter" => "web user",
      "quote" => "A picture is worth one k pixels",
      "attribution" => "Me",
    }

    @quote = FileModel.create(attrs)
    render :quote
  end

  def quote_1
    @quote = FileModel.find(1)
    render :quote
  end

  def exception
    raise "Oops"
  end
end