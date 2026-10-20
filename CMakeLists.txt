cmake_minimum_required(VERSION 3.16)

project(CppCICDDemo LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(calculator src/calculator.cpp)

target_include_directories(calculator
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_executable(app src/main.cpp)
target_link_libraries(app PRIVATE calculator)

enable_testing()

add_executable(test_calculator
    tests/test_calculator.cpp
)
target_link_libraries(test_calculator PRIVATE calculator)

add_test(NAME CalculatorTest COMMAND test_calculator)