ActiveAdmin.register Winner do
  actions :index

  index do
    column "Subscriber" do |winner|
      winner.assigned == true ? winner.subscriber.email : "Subscriber##{winner.subscriber_id}"
    end
    column "Prize" do |winner|
      winner.prize.description
    end
    column :assigned
    column :date_won
  end

end
