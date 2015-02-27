ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    
    columns do
      
      column do
        panel "Recent Winners" do
          winners = Winner.order("date_won DESC").limit(5)
          table_for winners do
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
      end
        
      column do
        panel "Recent Subscribers" do
          subscribers = Subscriber.order("created_at DESC").limit(5)
          table_for subscribers do
           column :id
           column :email
           column :created_at
          end
        end
      end
      
      column do
        panel "Recent Prizes" do
          prizes = Prize.order("created_at DESC").limit(5)
          table_for prizes do
           column :description
           column :existences
          end
        end
      end
      
    end
    
  end 
end
