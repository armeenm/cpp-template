project(
  'template',
  'cpp',
  version: '0.1.0',
  license: 'MIT',
  meson_version: '>=0.55.0',
  default_options: [
    'cpp_std=c++20',
    'buildtype=debug',
    'b_ndebug=if-release',
    'warning_level=3',
    'b_lto=true'
  ]
)

add_project_arguments(
  '-Wconversion',
  '-Wduplicated-branches',
  '-Wduplicated-cond',
  '-Wformat=2',
  '-Wlogical-op',
  '-Wnull-dereference',
  '-Wold-style-cast',
  '-Wpedantic',
  '-Wshadow',
  '-Wuseless-cast',
  language: 'cpp'
)

executable(
  'template',
  ['src/main.cpp'],
  #dependencies: [dependency('fmt')],
  install: true
)
