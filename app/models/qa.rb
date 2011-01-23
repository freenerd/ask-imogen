class QA < ActiveRecord::Base
  belongs_to :question, :class_name => "Track", :dependent => :destroy
  belongs_to :answer, :class_name => "Track", :dependent => :destroy
end
