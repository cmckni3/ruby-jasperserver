require 'test_helper'

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { record: :new_episodes, erb: true }
  c.filter_sensitive_data('<USERNAME>') { Rails.configuration.jasperserver[Rails.env.to_sym][:username] }
  c.filter_sensitive_data('<PASSWORD>') { Rails.configuration.jasperserver[Rails.env.to_sym][:password] }
  c.filter_sensitive_data('<URL>') { Rails.configuration.jasperserver[Rails.env.to_sym][:url] }
  c.filter_sensitive_data('<SET-COOKIE>') do |interaction|
    interaction.response.headers['Set-Cookie'].first if interaction.response.headers['Set-Cookie']
  end
  c.filter_sensitive_data('<COOKIE>') do |interaction|
    interaction.request.headers['Cookie'].first if interaction.request.headers['Cookie']
  end
  c.filter_sensitive_data('<SERVER>') do |interaction|
    interaction.response.headers['Server'].first if interaction.response.headers['Server']
  end
end

class JasperserverRailsTest < ActiveSupport::TestCase
  test "test.pdf is generated" do
    VCR.use_cassette('test1') do
      JasperserverRails::Jasperserver.new do
        format 'pdf'
        report 'samples/Department'
        params({ Value1: 'Value1', Value2: 'Value2' })
        run_report('test/dummy/tmp/reports/test.pdf')
      end
    end
    File.exists?('test/dummy/tmp/reports/test.pdf')
  end

  test "test2.pdf is generated" do
    VCR.use_cassette('test2') do
      JasperserverRails::Jasperserver.new do
        format 'pdf'
        report 'samples/Department'
        params({ Value1: 'Value1' })
        run_report('test/dummy/tmp/reports/test2.pdf')
      end
    end
    File.exists?('test/dummy/tmp/reports/test2.pdf')
  end

  test "test3.pdf is generated" do
    VCR.use_cassette('test3') do
      JasperserverRails::Jasperserver.new.run_report 'test/dummy/tmp/reports/test3.pdf' do
        format 'pdf'
        report 'samples/Department'
        params({ Value1: 'Value1' })
      end
    end
    File.exists?('test/dummy/tmp/reports/test3.pdf')
  end

  test "stays logged in when running multiple reports" do
    VCR.use_cassette('test4') do
      JasperserverRails::Jasperserver.new.run_report 'test/dummy/tmp/reports/test4.pdf' do
        format 'pdf'
        report 'samples/Department'
        params({ Value1: 'Value1' })
      end
    end
    File.exists?('test/dummy/tmp/reports/test4.pdf')

    VCR.use_cassette('test5') do
      JasperserverRails::Jasperserver.new.run_report 'test/dummy/tmp/reports/test5.pdf' do
        format 'pdf'
        report 'samples/Department'
        params({ Value1: 'Value1' })
      end
    end
    File.exists?('test/dummy/tmp/reports/test5.pdf')
  end
end
