# module CapybaraMatchers
# 	def has_heading?(text)
# 		has_css?("h1, h2, h3, h4, h5, h6", text: text)
# 	end
# end

# Capybara::Session.include(CapybaraMatchers)

RSpec::Matchers.define :have_heading do |text|
	match do |page|
		page.has_css?("h1,h2,h3,h4,h5,h6", text: text)
	end

	failure_message do 
		"Expected page to have heading '#{text}'"
	end

	failure_message_when_negated do |policy|
		"Expected page not to have heading '#{text}'"
	end
end