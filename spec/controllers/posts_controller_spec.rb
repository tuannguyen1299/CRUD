require	'rails_helper'
# require "paperclip/matchers"
Devise::Test::ControllerHelpers

RSpec.describe	PostsController	do
  describe 'GET #new' do
    it "assigns a new posts to @post" do
      sign_in create(:user)
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'GET #index' do
    it "renders the :index template" do
      sign_in create(:user)
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "creates a new post" do
        sign_in create(:user)
        create (:post),
        post: {title:"Tuan", describe:"tuannguyen", content:"nguyensytuan",
        image: File.open(Rails.root + 'spec/factories/fixtures/images/anh1.png')}

        expect(flash["success"]).to eq("success")
        expect(response).to redirect_to(posts_path)
      end
    end
    context "with invalid attributes" do
      it "does not save the new post" do
        sign_in create(:user)
        create (:post),
        post: {title:"", describe:"tuannguyen", content:"nguyensytuan",
          image:"factories/fixtures/images/anh1.png"}

          expect(flash["alert"]).to eq("alert")
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'UPDATE #edit' do
    context "valid attributes" do
      it "locates the requested @post" do
        sign_in create(:user)
        @post = create(:post)
        patch :update, :id => @post.id, post: attributes_for(:post)
        expect(assigns(:post)).to eq(@post)
      end

      it "changes @post's attributes" do
        sign_in create(:user)
        @post = create(:post)
        patch :update, id: @post,
        post: attributes_for(:post,
          title: 'test title', describe: 'test describe',
          content: 'test content',
          image:'anh1.png')
        @post.reload
        expect(@post.title).to eq('test title')
        expect(@post.describe).to eq('test describe')
        expect(@post.content).to eq('test content')
      end

      it "redirects to the updated post" do
        sign_in create(:user)
        @post = create(:post)
        patch :update, id: @post, post: attributes_for(:post)
        expect(flash["success"]).to eq("success")
        expect(response).to redirect_to(post_path)
      end
    end

    context "invalid attributes" do
      it "locates the requested @post" do
        sign_in create(:user)
        @post = create(:post)
        patch :edit, id: @post, post: attributes_for(:post)
        expect(assigns(:post)).to eq(@post)
      end

      it "does not change @post attributes" do
        sign_in create(:user)
        @post = create(:post)
        patch :edit, id: @post,
        post: FactoryGirl.attributes_for(:post,
            title: nil, describe: nil,
            content: 'test content',
            image:'anh1.png')
        @post.reload
        @post.title.should_not eq("test title")
        @post.describe.should_not eq("test describe")
        @post.content.should_not eq("test content")
        @post.image.should_not eq("anh1.png")
      end

      it "re-renders the edit method" do
        sign_in create(:user)
        @post = create(:post)
        patch :edit, id: @post, post: attributes_for(:post)
        expect(flash["danger"]).to eq nil
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroys' do
    it "when delete posts" do
      sign_in create(:user)
      @post = create(:post)
      expect{delete :destroy, id: @post}.to change(Post,:count).by(-1)
      expect(response).to redirect_to posts_url
    end
  end
end
