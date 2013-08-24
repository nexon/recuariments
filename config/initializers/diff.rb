class Diff
  extend HTMLDiff
  
  def self.differ(values)
    unless values.blank? || values.first.blank?
      diff(values.first,values.last)
    else
      ""
    end
  end
end