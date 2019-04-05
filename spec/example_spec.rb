require 'spec_helper'

describe 'These examples' do
  it 'can be used to confirm if a method is present in required relative' do
    expect { test_method }.not_to raise_error
  end

  it 'can be used to confirm if a method is not present in required relative' do
    expect { second_test_method }.to raise_error(NameError)
  end

  it 'can be used to confirm if a method returns expected results in required relative' do
    expect(test_method).to eq('bears') # equal(): strict comparison, eq(): value comparison
  end

  it 'can be used to confirm if a class contains a specific method' do
    expect(ExampleClass).to respond_to(:class_test)
  end

  it 'can be used to confirm if an instance method returns the expected results' do
    example = ExampleClass.new
    expect(example.instance_test).to eq('seriously')
  end

  it 'can be used to match strings' do
    expect('There are two bears in a tree').to match(/bears in a tree/)
    expect("They're both on the same limb").to include('limb')
  end

  it 'can check types' do
    example = ExampleClass.new
    expect(example).to be_instance_of(ExampleClass)

    example_array = [1, 2, 3]
    expect(example_array).to be_kind_of(Array)
  end
end
