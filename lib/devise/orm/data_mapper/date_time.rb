# Add DateTime#gmtime method if needed.
class DateTime
  unless method_defined?(:gmtime)
    delegate :gmtime, :to => :to_time
  end
end
