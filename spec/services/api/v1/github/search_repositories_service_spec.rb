# frozen_string_literal: true

require 'rails_helper'
# vcr: { record: :none }
RSpec.describe(Api::V1::Github::SearchRepositoriesService, type: :service, vcr: { record: :none }) do
  describe '#call' do
    let(:options) { { per_page: 2, page: 1 } }
    let(:connection) do
      Api::V1::HttpClient.call(token: 'bb06832b63a8639e04020967d048940feff31658').payload
    end

    context 'when it is success' do
      describe 'with valid username' do
        subject(:repositories) { repositories_response.payload }

        let(:repositories_response) { described_class.call(connection:, username: 'octocat', options:) }

        it 'has correct types' do
          expect(repositories_response).to have_attributes(success?: true, payload: Array, error: nil)
        end

        it { expect(repositories.size).to eq(2) }

        it 'has all the right attributes' do
          expect(repositories.first).to include(
            'id' => 132_935_648,
            'name' => 'boysenberry-repo-1',
            'full_name' => 'octocat/boysenberry-repo-1',
            'html_url' => 'https://github.com/octocat/boysenberry-repo-1',
            'forks_count' => 9
          )
        end
      end
    end

    context 'when it fails' do
      describe 'with invalid username' do
        it 'has correct types' do
          result = described_class.call(connection:, username: nil)
          expect(result).to have_attributes(success?: false, payload: {}, error: StandardError)
        end
      end
    end
  end
end
