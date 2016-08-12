require 'spec_helper'

describe RestUri::Resource do
  describe '.resource_id' do
    let (:resource) { RestUri::Resource }
    let (:status_id) { 540897316908331009 }
    describe 'takes string URL and extract ID' do
      subject { resource.resource_id('status', "https://twitter.com/sferik/status/#{status_id}/") }
      it { is_expected.to equal status_id }
    end

    describe 'takes URL object and extract ID' do
      subject { resource.resource_id('status', URI.parse("https://twitter.com/sferik/status/#{status_id}/")) }
      it { is_expected.to equal status_id }
    end

    describe 'takes plural name and return resource ID' do
      subject { resource.resource_id('statuses', "https://twitter.com/sferik/status/#{status_id}/") }
      it { is_expected.to equal status_id }
    end

    describe 'takes capital case name and return resource ID' do
      subject { resource.resource_id('Status', "https://twitter.com/sferik/status/#{status_id}/") }
      it { is_expected.to equal status_id }
    end

    describe 'takes camel case name and return resource ID' do
      subject { resource.resource_id('UserStatus', "https://twitter.com/sferik/user_status/#{status_id}/") }
      it { is_expected.to equal status_id }
    end

    describe 'takes underscored name and return resource ID' do
      subject { resource.resource_id('user_status', "https://twitter.com/sferik/user_status/#{status_id}/") }
      it { is_expected.to equal status_id }
    end

    describe 'takes unknown resource name' do
      subject { resource.resource_id('foo', "https://twitter.com/sferik/status/#{status_id}/") }
      it { is_expected.to be_nil }
    end

    describe 'takes empty resource name' do
      subject { resource.resource_id('', "https://twitter.com/sferik/status/#{status_id}/") }
      it { is_expected.to be_nil }
    end

  end

end
