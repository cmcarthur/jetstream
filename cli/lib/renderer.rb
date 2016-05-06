require './lib/components/repository'

module Jet
  class Renderer
    def initialize(repository)
      @repository = repository
    end

    def render_all!
      master = ""

      @repository.build_all!

      @repository.state.each do |component|
        master.concat component[:ref].render
      end

      return master
    end
  end
end
