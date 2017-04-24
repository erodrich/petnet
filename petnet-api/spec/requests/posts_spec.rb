require 'rails_helper'

RSpec.describe 'Post API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:pet) { create(:pet, created_by: user.id) }
  let!(:post) { create(:post, pet_id: pet.id) }
  let(:pet_id) { pet.id }
  let(:id) { post.id }
  let(:headers) { valid_headers }

  # Test suite for GET /todos/:todo_id/items
  describe 'GET /pets/:pet_id/posts' do
    before { get "/pets/#{pet_id}/posts", params: {}, headers: headers  }

    context 'when pet exists' do
      it 'returns the pet' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(pet_id)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when pet does not exist' do
      let(:pet_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Pet/)
      end
    end
  end

  # Test suite for GET /todos/:todo_id/items/:id
  describe 'GET /pets/:pet_id/posts/:id' do
    before { get "/pets/#{pet_id}/posts/#{id}", params: {}, headers: headers }

    context 'when pet post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the post' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when pet post does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items
  describe 'POST /pets/:pet_id/posts' do
    let(:valid_attributes) { { title: 'Visit Narnia', content: "El perro es bonito", active: true }.to_json }

    context 'when request attributes are valid' do
      before do 
          post "/pets/#{pet_id}/posts", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/pets/#{pet_id}/posts", params: {}, headers: headers  }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items/:id
  describe 'PUT /pets/:pet_id/posts/:id' do
    
    let(:valid_attributes) { { title: 'Mozart' }.to_json }

    before do
        put "/pets/#{pet_id}/posts/#{id}", params: valid_attributes, headers: headers
    end

    context 'when post exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the post' do
        updated_post = Post.find(id)
        expect(updated_post.name).to match(/Mozart/)
      end
    end

    context 'when the post does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /pets/:id' do
    before { delete "/pets/#{pet_id}/posts/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end