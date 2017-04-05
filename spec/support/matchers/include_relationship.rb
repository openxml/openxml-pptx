RSpec::Matchers.define :include_relationship do |type, target|
  match do |object|
    object.relationships.any? { |relationship|
      relationship.type == type && relationship.target = target
    }
  end
end

