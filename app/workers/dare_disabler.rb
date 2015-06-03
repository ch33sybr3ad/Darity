class DareDisabler
  include Sidekiq::Worker

  def perform(dare_id)
    dare = Dare.find(dare_id)
    two_weeks = dare.created_at + (2*7*24*60*60)

    if dare.price 
      if Time.now.to_date.to_s > dare.updated_at + (1*7*24*60*60)

      end

      if dare.created_at.to_date.to_s > two_weeks.to_date.to_s 
        dare.delete
      end
    end
  end
end