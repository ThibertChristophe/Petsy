class ApplicationRecord < ActiveRecord::Base
  include ImageConcern
  primary_abstract_class
end
