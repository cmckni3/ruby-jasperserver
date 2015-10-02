require 'test_helper'

require 'vcr'

VCR.configure do |c|
  jasper_config = Rails.configuration.jasperserver[Rails.env.to_sym]
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { record: :none, erb: true }
  c.filter_sensitive_data('<USERNAME>') { jasper_config[:username] }
  c.filter_sensitive_data('<PASSWORD>') { jasper_config[:password] }
  c.filter_sensitive_data('<URL>') { jasper_config[:url] }
  c.filter_sensitive_data('<SET-COOKIE>') do |interaction|
    if interaction.response.headers['Set-Cookie']
      interaction.response.headers['Set-Cookie'].first
    end
  end
  c.filter_sensitive_data('<COOKIE>') do |interaction|
    if interaction.request.headers['Cookie']
      interaction.request.headers['Cookie'].first
    end
  end
  c.filter_sensitive_data('<SERVER>') do |interaction|
    if interaction.response.headers['Server']
      interaction.response.headers['Server'].first
    end
  end
end

class JasperserverRailsTest < ActiveSupport::TestCase
  test 'test.pdf is generated' do
    report_file = 'test/dummy/tmp/reports/test.pdf'
    VCR.use_cassette 'test1' do
      JasperserverRails::Jasperserver.new do
        format 'pdf'
        report 'reports/samples/Department'
        params({ Value1: 'Value1', Value2: 'Value2' })
        run_report report_file
      end
    end
    File.exist? report_file
  end

  test 'test2.pdf is generated' do
    report_file = 'test/dummy/tmp/reports/test2.pdf'
    VCR.use_cassette 'test2' do
      JasperserverRails::Jasperserver.new do
        format 'pdf'
        report 'reports/samples/Department'
        params({ Value1: 'Value1' })
        run_report report_file
      end
    end
    File.exist? report_file
  end

  test 'test3.pdf is generated' do
    report_file = 'test/dummy/tmp/reports/test3.pdf'
    VCR.use_cassette 'test3' do
      JasperserverRails::Jasperserver.new.run_report report_file do
        format 'pdf'
        report 'reports/samples/Department'
        params({ Value1: 'Value1' })
      end
    end
    File.exist? report_file
  end

  test 'stays logged in when running multiple reports' do
    report_file = 'test/dummy/tmp/reports/test4.pdf'
    VCR.use_cassette 'test4' do
      JasperserverRails::Jasperserver.new.run_report report_file do
        format 'pdf'
        report 'reports/samples/Department'
        params({ Value1: 'Value1' })
      end
    end
    File.exist? report_file

    report_file = 'test/dummy/tmp/reports/test5.pdf'
    VCR.use_cassette 'test5' do
      JasperserverRails::Jasperserver.new.run_report report_file do
        format 'pdf'
        report 'reports/samples/Department'
        params({ Value1: 'Value1' })
      end
    end
    File.exist? report_file
  end
end
