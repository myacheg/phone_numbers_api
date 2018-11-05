require 'rails_helper'

describe CreateNumberService do
  context 'single record' do
    let(:user_name)     { 'test name' }
    let(:number)        { nil }
    let(:number_params) { { user_name: user_name, number: number } }
    let(:db_record)     { Number.last }

    it 'creates record for user with first number' do
      expect{ described_class.call(number_params) }.to change(Number, :count).by(1)
      expect(db_record.number).to    eq Number::FIRST_NUMBER
      expect(db_record.user_name).to eq user_name
      expect(db_record.custom_number).to be false
    end

    context 'with custom number' do
      let(:number) { '111-111-3333' }

      before { described_class.call(number_params) }

      it 'creates record for user with number from params' do
        expect(db_record.number).to        eq number.tr('-', '').to_i
        expect(db_record.user_name).to     eq user_name
        expect(db_record.custom_number).to be true
      end

      context 'custom number exists' do
        it 'creates regular number' do
          expect{ described_class.call(number_params) }.to change(Number, :count).by(1)
          expect(db_record.number).to    eq Number::FIRST_NUMBER
          expect(db_record.user_name).to eq user_name
          expect(db_record.custom_number).to be false
        end
      end
    end
  end

  context 'multiple records' do
    describe 'request new number for user' do
      let(:user_name)     { 'test name' }
      let(:number)        { nil }
      let(:number_params) { { user_name: user_name, number: number } }
      let(:next_number)   { Number::FIRST_NUMBER + 1 }
      let(:db_record)     { Number.last }

      before {  described_class.call(user_name: user_name)  }

      it 'creates record with next available number for user' do
        expect{ described_class.call(number_params) }.to change(Number, :count).by(1)
        expect(db_record.number).to    eq next_number
        expect(db_record.user_name).to eq user_name
        expect(db_record.custom_number).to be false
      end

      context 'with existed next number' do
        before do
          described_class.call(user_name: user_name)
          described_class.call(user_name: user_name, number: Number.stringified(next_number))
        end

        it 'creates record with next available number for user' do
          expect{ described_class.call(number_params) }.to change(Number, :count).by(1)
          expect(db_record.user_name).to eq user_name
          expect(db_record.custom_number).to be false
        end
      end
    end
  end
end