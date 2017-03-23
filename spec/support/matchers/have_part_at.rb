RSpec::Matchers.define :have_part_at do |part_path|
  match do |package|
    @actual = distill(package.get_part(part_path).content)
    values_match? @expected, @actual
  end

  chain :with_content do |expected_content|
    @expected = distill(expected_content)
  end

  define_method :ignore_ids do |content|
    content.gsub(/ Id="[^"]+"/, "")
  end

  define_method :squish do |content|
    content.gsub(/[\n\r]/, "")
  end

  define_method :distill do |content|
    squish(ignore_ids(content))
  end

  failure_message do
    """
    Expected #{part_path} to be
    #{@expected.inspect.gsub("<", "\n<")}
    but got
    #{@actual.inspect.gsub("<", "\n<")}
    """
  end
end
