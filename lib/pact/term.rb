module Pact
  class Term

    attr_reader :generate, :matcher

    def self.json_create(obj)
      new(generate: obj['data']['generate'], matcher: obj['data']['matcher'])
    end

    def initialize(options = {})
      @generate = options[:generate]
      @matcher = options[:matcher]
    end

    def to_json(options = {})
      { json_class: self.class.name, data: { generate: generate, matcher: matcher} }.to_json(options)
    end

    def match(literal)
      literal.respond_to?(:to_s) ? matcher.match(literal.to_s) : nil
    end

    def ==(other)
      return false unless other.respond_to?(:generate) && other.respond_to?(:matcher)
      generate == other.generate && matcher == other.matcher
    end

    def diff_with_actual(actual)
      match(actual) ? nil : {
        expected: self,
        actual: actual
      }
    end

  end
end