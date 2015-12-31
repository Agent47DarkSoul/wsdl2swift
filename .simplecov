SimpleCov.start do
  add_filter 'vendor/'
  add_filter 'spec/'
  add_filter 'features/'
end
SimpleCov.coverage_dir 'coverage'
