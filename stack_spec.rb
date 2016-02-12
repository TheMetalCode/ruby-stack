require 'rspec'
require_relative 'stack'

RSpec.describe Stack do

  let(:backing_array) { [1, 2.34, 'string', {hey_look: 'a hash'}, %w(another array)] }
  let(:stack) { Stack.new(backing_array) }

  context '#size' do
    subject { stack.size }
    it { is_expected.to eq(backing_array.size) }
  end

  context '#push' do

    context 'rejects nil input' do
      let(:input) { nil }
      # lambda here means we're asserting the effects of the method, not the return value
      subject { -> { stack.push(input) } }
      it { is_expected.to raise_error(ArgumentError) }
    end

    context 'accepts valid input' do
      let(:input) { 86753.09 }

      context 'adds input to front' do
        subject { stack.push(input) }
        specify { expect(subject.backing_array[0]).to eq(input) }
      end

      context 'changes size by 1' do
        subject { -> { stack.push(input) } }
        it { is_expected.to change(stack, :size).by(1) }
      end
    end
  end

  context '#peek' do

    context 'handles empty stack' do
      let(:stack) { Stack.new([]) }
      subject { -> { stack.peek } }
      it { is_expected.to raise_error(StandardError) }
    end

    context 'returns front element' do
      subject { stack.peek }
      it { is_expected.to eq(backing_array[0]) }
    end

    context 'changes size by 0' do
      subject { -> { stack.peek } }
      it { is_expected.to_not change(stack, :size) }
    end
  end

  context '#pop' do

    context 'handles empty stack' do
      let(:stack) { Stack.new([]) }
      subject { -> { stack.pop } }
      it { is_expected.to raise_error(StandardError) }
    end

    context 'removes from front' do
      subject { stack.pop }
      it { is_expected.to eq(backing_array[0]) }
    end

    context 'changes size by -1' do
      subject { -> { stack.pop } }
      it { is_expected.to change(stack, :size).by(-1) }
    end
  end

  context '#has_value?' do

    context 'handles nil input' do
      let(:input) { nil }
      subject { -> { stack.has_value?(input) } }
      it { is_expected.to raise_error(ArgumentError) }
    end

    context 'stack has input value' do
      let(:input) { backing_array[2] }
      subject { stack.has_value?(input) }
      it { is_expected.to be_truthy }
    end

    context 'stack does not have input value' do
      let(:input) { 'flaming bacon' }
      subject { stack.has_value?(input) }
      it { is_expected.to be_falsey }
    end
  end
end