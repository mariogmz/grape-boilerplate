# frozen_string_literal: true

require "test_helper"

class JwtTokenServiceTest < MiniTest::Test
  include JwtMethods

  def setup
    @service = JwtTokenService.new
  end

  def test_encode
    @service.expects(:private_key).returns(rsa_private)
    assert_kind_of String, @service.encode(payload)
  end

  def test_decode
    @service.expects(:public_key).returns(rsa_public)
    result = @service.decode(token)
    assert_kind_of Array, result
    assert_equal payload, result[0]
  end
end
