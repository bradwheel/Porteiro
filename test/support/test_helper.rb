require 'porteiro'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'

report_options = {color: true}
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(report_options)]
