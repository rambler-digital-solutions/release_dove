# frozen_string_literal: true
require 'spec_helper'

describe ReleaseDove do
  it 'has a version number' do
    expect(ReleaseDove::VERSION).not_to be nil
  end

  it ' Release.size returns 1' do
    expect(ReleaseDove::Release.size).to eq(1)
  end

  it ' Release.first.date returns the date of first release - 14th Oct of 2016' do
    expect(ReleaseDove::Release.first.date).to eq(Date.new(2016, 10, 14))
  end

  it ' Release.first.version returns the version of first release - 0.1.0' do
    expect(ReleaseDove::Release.first.version).to eq('0.1.0')
  end
end
