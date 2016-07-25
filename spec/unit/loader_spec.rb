require 'dry/component/loader'
require 'singleton'

RSpec.describe Dry::Component::Loader do
  before do
    module Test
      class Bar
      end
    end
  end

  shared_examples_for 'a valid component' do
    describe '#constant' do
      it 'returns the constant' do
        expect(component.constant).to be(Test::Bar)
      end
    end

    describe '#identifier' do
      it 'returns container identifier' do
        expect(component.identifier).to eql('test.bar')
      end
    end

    describe '#path' do
      it 'returns relative path to file defining the component constant' do
        expect(component.path).to eql('test/bar')
      end
    end

    describe '#file' do
      it 'returns relative path to file with ext defining the component constant' do
        expect(component.file).to eql('test/bar.rb')
      end
    end

    describe '#instance' do
      it 'builds a component class instance' do
        expect(component.instance).to be_instance_of(Test::Bar)
      end
    end
  end

  context 'from identifier as a symbol' do
    subject(:component) { Dry::Component::Loader.new(:'test.bar') }

    it_behaves_like 'a valid component'
  end

  context 'from identifier as a string' do
    subject(:component) { Dry::Component::Loader.new('test.bar') }

    it_behaves_like 'a valid component'
  end

  context 'from path' do
    subject(:component) { Dry::Component::Loader.new('test/bar') }

    it_behaves_like 'a valid component'
  end

  context 'singleton' do
    before do
        module Test
          remove_const(:Bar)
          class Bar
            include Singleton
          end
        end
      end
      subject(:component) { Dry::Component::Loader.new('test/bar') }

      it_behaves_like 'a valid component'
    end
end
