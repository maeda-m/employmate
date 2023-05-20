# frozen_string_literal: true

require_relative 'lib/national_government_organization_holiday/version'

Gem::Specification.new do |spec|
  spec.name = 'national_government_organization_holiday'
  spec.version = NationalGovernmentOrganizationHoliday::VERSION
  spec.authors = ['Minoru Maeda']
  spec.summary = '行政機関の休日を計算する。'
  spec.required_ruby_version = '>= 3.2.2'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 7.0'
  spec.add_dependency 'holiday_japan', '~> 1.4'
end
