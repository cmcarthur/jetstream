module Jet
  module Component
    class Builder
      @@cache = {}

      def self.get(key)
        return @@cache[key]
      end

      def self.store!(item)
        @@cache[item.hash] = item
      end

      def self.build(component)
        if not component.valid?
          return false
        end

        rendered = []

        component.dependencies.each do |dependency|
          rendered.concat(self.build(dependency.new))
        end

        self.store! component
        rendered.push(component.build)
      end

      def self.render(component)
        built = self.build(component)

        if built
          return built.join("\n\n")
        else
          return built
        end
      end

    end
  end
end
