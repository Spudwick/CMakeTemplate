
add_executable(sandbox EXCLUDE_FROM_ALL "sandbox.cpp" "sandbox.h")

target_link_libraries(sandbox PUBLIC LibTest)
