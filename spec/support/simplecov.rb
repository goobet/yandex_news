if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_group 'Services', 'app/services'
    add_filter { |source_file| source_file.lines.count < 3 }
    add_filter '/channels'
  end
end
