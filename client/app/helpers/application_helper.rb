module ApplicationHelper
  def tweet_button(args)
    link_to args[:message], "https://twitter.com/intent/tweet?text=%23Viral%20#{args[:dare].title}%20-%20dared%20to%20%40#{args[:dare].daree.username}%20proposed%20by%20%40#{args[:dare].proposer.username}%20%23Darity%20%23Dare%20For%20%23Charity%20see%20dare%20here%20localhost:3000/users/#{args[:user].id}/dares/#{args[:dare].id}&url=localhost:3000/users/#{args[:user].id}/dares/#{args[:dare].id}", "data-via" => "#{args[:dare].proposer}", "data-related" => "#{args[:dare].daree}", class: 'btn btn-primary'
  end
end

