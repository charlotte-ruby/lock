Given /^application controller blank$/ do
  
end

Given /^application controller lock setup$/ do
  ApplicationController.class_eval do
    lock
  end
end

Given /^application controller lock controller setup$/ do
  ApplicationController.class_eval do
    lock :actions=>["widgets"]
  end
end

Given /^application controller lock single action setup$/ do
  ApplicationController.class_eval do
    lock :actions=>["widgets#new"]
  end
end

Given /^application controller lock multiple action setup$/ do
  ApplicationController.class_eval do
    lock :actions=>["widgets#new","wadgets#index"]
  end
end

Given /^application controller lock mixed setup$/ do
  ApplicationController.class_eval do
    lock :actions=>["widgets", "wadgets#index"]
  end
end
