# frozen_string_literal: true

require 'teamtailor/parser/candidate'

module Teamtailor
  class Parser
    def self.parse(payload)
      new(payload).parse
    end

    def parse
      data.map do |record|
        case record&.dig('type')
        when 'candidates'
          Teamtailor::Candidate.new(record)

        else
          raise Teamtailor::UnknownResponseTypeError.new(record&.dig('type'))
        end
      end
    end

    private

    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def data
      [payload&.dig('data')].flatten
    end
  end
end