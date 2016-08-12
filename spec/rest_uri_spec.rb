require 'spec_helper'

describe RestUri do

  it 'has a version number' do
    expect(RestUri::VERSION).not_to be nil
  end

  let!(:username) { 'i05' }
  let!(:status_id) { 658113992410292224 }
  let!(:photo_id) { 1 }

  context 'with singular resource' do
    subject(:rest_uri) { RestUri.parse("https://twitter.com/#{username}/status/#{status_id}") }
    it { expect(rest_uri).to be_instance_of(RestUri::Base)}
    it { expect(rest_uri.status_id).to eq status_id }
    it { expect(rest_uri.statuses_id).to eq status_id }
  end

  context 'with plural resource' do
    subject(:rest_uri) { RestUri.parse("https://twitter.com/#{username}/statuses/#{status_id}") }
    it { expect(rest_uri).to be_instance_of(RestUri::Base)}
    it { expect(rest_uri.status_id).to eq status_id }
    it { expect(rest_uri.statuses_id).to eq status_id }
  end

  context 'with multiple resources' do
    subject(:rest_uri) { RestUri.parse("https://twitter.com/#{username}/status/#{status_id}/photo/#{photo_id}") }
    it { expect(rest_uri).to be_instance_of(RestUri::Base)}
    it { expect(rest_uri.status_id).to eq status_id }
    it { expect(rest_uri.photo_id).to eq photo_id }
  end

  context 'with parser option' do
    subject(:rest_uri) {
      require 'addressable/uri'
      RestUri.parse("https://漢字.com/#{username}/status/#{status_id}", parser: Addressable::URI)
    }
    it { expect(rest_uri).to be_instance_of(RestUri::Base)}
    it { expect(rest_uri.parser).to be Addressable::URI}
    it { expect(rest_uri.status_id).to eq status_id }
  end

  context 'with identifier option' do
    subject(:rest_uri) {
      RestUri.parse(
        "https://example.com/#{username}/status/#{status_id}",
        identifier: :_foo)
    }
    it { expect(rest_uri).to be_instance_of(RestUri::Base)}
    it { expect(rest_uri.status_foo).to eq status_id }

    subject(:empty_identifier) {
      RestUri.parse(
        "https://example.com/#{username}/status/#{status_id}",
        identifier: :'')
    }
    it { expect {empty_identifier}.to raise_error(ArgumentError)}
  end
end
