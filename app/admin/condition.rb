ActiveAdmin.register Condition do

  permit_params :prize_id, :cond_type, :criteria, :offset

  form do |f|
    inputs 'Conditions' do
      input :prize_id, as: :select, collection: Prize.all.map { |p| [p.description, p.id] }
      input :cond_type, as: :select, include_blank: false, collection: [['multiples', '%'], ['less than', '<'], ['greater than', '>'], ['list', 'list']]
      li "For list of subscribers, add the numbers of the subscribers separated by a comma(,)"
      input :criteria
      input :offset, label: 'After'
    end
    actions
  end
end
