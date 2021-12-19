# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__) # checks the local directory first before anything else
require "rulers"

require "rack/test"
require "minitest/autorun"
