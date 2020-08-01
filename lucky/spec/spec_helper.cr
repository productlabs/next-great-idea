ENV["LUCKY_ENV"] = "test"
ENV["DEV_PORT"] = "5001"
require "spec"
require "webmock"
require "../src/app"
require "./support/**"

# Add/modify files in spec/setup to start/configure programs or run hooks
#
# By default there are scripts for setting up and cleaning the database,
# configuring LuckyFlow, starting the app server, etc.
require "./setup/**"

include Carbon::Expectations
include Lucky::RequestExpectations

Habitat.raise_if_missing_settings!

_has_connection = false
Spec.before_each do
  if !_has_connection
    EnsureServerConnection.run
    _has_connection = true
  end
end
