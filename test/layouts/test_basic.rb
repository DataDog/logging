# $Id$

require 'test/setup.rb'

module TestLogging
module TestLayouts

  class TestBasic < Test::Unit::TestCase
    include LoggingTestCase

    def setup
      super
      ::Logging.define_levels %w(debug info warn error fatal)
      @layout = ::Logging::Layouts::Basic.new
      @levels = ::Logging::LEVELS
    end

    def test_format
      event = ::Logging::LogEvent.new( 'ArrayLogger', @levels['info'],
                                       'log message', false)
      assert_equal " INFO  ArrayLogger : log message\n", @layout.format(event)

      event.data = [1, 2, 3, 4]
      assert_equal " INFO  ArrayLogger : <Array> 1234\n", @layout.format(event)

      event.level = @levels['debug']
      event.data = 'and another message'
      log = "DEBUG  ArrayLogger : and another message\n"
      assert_equal log, @layout.format(event)

      event.logger = 'Test'
      event.level = @levels['fatal']
      event.data = Exception.new
      log = "FATAL  Test : <Exception> Exception\n"
      assert_equal log, @layout.format(event)
    end

  end  # class TestBasic

end  # module TestLayouts
end  # module TestLogging

# EOF
