class List < ApplicationRecord
  belongs_to :user
  belongs_to :priority
  require 'time_difference'

  def priority_with_name
    if self.priority_id != nil
      return "#{priority.name}"
    else
      return "ไม่ได้ระบุความสำคัญ"
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

  def show_startdate
    if self.startdate != nil && self.startdate != ''
      return "#{self.startdate.strftime("%A %d-%B-%Y")}"
    else
      return "ไม่ได้ระบุวันเริ่มต้น"
    end
  end

  def show_dateline
    if self.dateline != nil  && self.dateline != ''
      return "#{self.dateline.strftime("%A %d-%B-%Y")}"
    else
      return "ไม่ได้ระบุวันสิ้นสุด"
    end
  end

  def cal_remain_date
    if self.startdate != nil && self.dateline != nil
      remain_date = (self.startdate) - (self.dateline)
      remain_date = TimeDifference.between(self.startdate , self.dateline).in_days.to_i
      return "#{remain_date} วัน"
    else
      return "ไม่ได้กำหนดวันเริ่มต้น และ วันสิ้นสุด"
    end
  end



end
