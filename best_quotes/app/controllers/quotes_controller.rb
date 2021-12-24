class QuotesController < Rulers::Controller
  def a_quote
    'There is nothing either good or bad, buttt thinking makes it so.' +
    "\n<code>\n#{env}\n</code>"
  end

  def exception
    raise "Oops"
  end
end