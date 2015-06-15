namespace :charity do

	task reset: [:clear, :scrape]

  desc "deletes charities in db"
  task clear: :environment do
  	Charity.delete_all
  end

  desc "scrapes for charities"
  task scrape: :environment do
  	a_e_charities = HTTParty.get('https://www.kimonolabs.com/api/ci5w4v76?apikey=jR0ep0PlzRAYmFSLYW4sScLoay3VFcDE')
  	charities_array = a_e_charities["results"]["collection1"]
  	charities_array = charities_array.shift(50)

  	charities_array.each do |charity|
  	  Charity.create!(
  	    name: charity["title"],
  	    url: charity["url"],
  	    mission: charity["misson"],
  	    transparency_score: charity["transparency score"],
  	  )
  	end
  end

end
