class QuotesController < Rulers::Controller
  def a_quote
    @noun = :winking
    render :a_quote
  end

  def exception
    raise "Oops"
  end
end