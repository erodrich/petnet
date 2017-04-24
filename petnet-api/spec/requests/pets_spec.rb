require 'rails_helper'

RSpec.describe 'Pets API', type: :request do
    #Initialize test data
    let(:user) { create(:user) }
    let!(:pets) { create_list(:pet, 10, created_by: user.id)}
    let(:pet_id) { pets.first.id }
    # authorize request
    let(:headers) { valid_headers }
    
    describe 'GET /pets' do
        before { get '/pets', params: {}, headers: headers }
        it 'return pets' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end
        
        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end
    
    describe 'GET /pets/:id' do
        before { get "/pets/#{pet_id}", params: {}, headers: headers }
        
        context 'when the record exists' do
            it 'returns the pet' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(pet_id)
            end
            
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end
        
        context 'when the record does not exist' do
            let(:pet_id) { 100 }
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Pet/)
            end
        end
    end
    
    describe 'POST /pets' do
        # valid payload
        let(:valid_attributes) do
          { name: 'Learn Elm', animal: 'perro', breed: 'doberman', created_by: user.id.to_s }.to_json
        end
        context 'when the request is valid' do
          before { post '/pets', params: valid_attributes, headers: headers }
    
          it 'creates a pet' do
            expect(json['name']).to eq('Learn Elm')
          end
    
          it 'returns status code 201' do
            expect(response).to have_http_status(201)
          end
        end
    
        context 'when the request is invalid' do
          let(:valid_attributes) { { name: nil  }.to_json }
          before { post '/pets', params: valid_attributes, headers: headers }
    
          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end
    
          it 'returns a validation failure message' do
            expect(response.body)
              .to match(/Validation failed: Name can't be blank/)
          end
        end
      end
    
      # Test suite for PUT /pets/:id
      describe 'PUT /pets/:id' do
        let(:valid_attributes) { { name: 'Shopping' }.to_json }
    
        context 'when the record exists' do
          before { put "/pets/#{pet_id}", params: valid_attributes, headers: headers }
    
          it 'updates the record' do
            expect(response.body).to be_empty
          end
    
          it 'returns status code 204' do
            expect(response).to have_http_status(204)
          end
        end
      end
    
      # Test suite for DELETE /todos/:id
      describe 'DELETE /pets/:id' do
        before { delete "/pets/#{pet_id}", params: {}, headers: headers }
    
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end
end