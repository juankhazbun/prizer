ActiveAdmin.register Condition do

  permit_params :prize_id, :cond_type, :criteria, :offset
  
  index do
    id_column
    column  "Condition" do |condition|
      types = {'%' => 'multiples of', '<' => 'less than', '>' => 'greater than'}
      msg = ""
      if condition.cond_type == "list"  
        msg = "Wins prize specific subscribers. Subscriber ##{condition.criteria.split(',').to_sentence(words_connector: ', #', two_words_connector: ' and #', last_word_connector: ' and #')}"
      else
        msg = "Wins prize subscribers #{types[condition.cond_type]} #{condition.criteria}" 
        msg += " after #{condition.offset}" unless condition.offset == ''  
      end
      msg
    end
    column "Prize" do |condition|
      condition.prize.description
    end
    column :created_at
    actions
  end

  # TODO: Hide offset when the condition type is a list
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
