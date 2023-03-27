# == Schema Information
#
# Table name: todos
#
#  id             :integer          not null, primary key
#  date_to_arrive :date
#  description    :string
#  details        :string
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
class Todo < ApplicationRecord
end
