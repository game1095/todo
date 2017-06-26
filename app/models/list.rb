class List < ApplicationRecord
  belongs_to :user
  belongs_to :priority

  def priority_with_name
    if self.priority_id != nil
      return "#{priority.name}"
    else
      return "FUCK"
    end
  end

  def priority_color
    if self.priority_id == 1
      return "rgba(233, 63, 63, 0.7)"
    elsif self.priority_id == 2
      return 'rgba(238, 164, 38, 0.7)'
    elsif self.priority_id == 3
      return 'rgba(69, 207, 212, 0.7)'
    end
  end

end
