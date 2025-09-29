require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:post_record) { create(:post, :with_image, user: user) }
  let!(:comments) { create_list(:comment, 3, post: post_record, user: user) }

  # html
  describe 'GET /posts/:post_id/comments.html' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get post_comments_path(post_record)

        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get post_comments_path(post_record)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  # json
  describe 'GET /posts/:post_id/comments.json' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get post_comments_path(post_record, format: :json), headers: { "ACCEPT" => "application/json" } # JSONをリクエスト

        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body.length).to eq 3
        expect(body[0]['content']).to eq comments.first.content
        expect(body[1]['content']).to eq comments.second.content
        expect(body[2]['content']).to eq comments.third.content
      end
    end

    context 'ログインしていない場合' do
      it '401ステータスが返ってくる' do
        get post_comments_path(post_record, format: :json), headers: { "ACCEPT" => "application/json" } # JSONをリクエスト

        expect(response).to have_http_status(401)
        body = JSON.parse(response.body)
        expect(body["error"]).to be_present
      end
    end
  end

  # json
  describe 'POST /posts/:post_id/comments.json' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'コメントが保存される' do
        comment_params = attributes_for(:comment)
        post post_comments_path(post_record, format: :json),
          params: { comment: comment_params },
          headers: { "ACCEPT" => "application/json" } # JSONをリクエスト

        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['content']).to eq(comment_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it '401ステータスが返ってくる' do
        get post_comments_path(post_record, format: :json), headers: { "ACCEPT" => "application/json" } # JSONをリクエスト

        expect(response).to have_http_status(401)
        body = JSON.parse(response.body)
        expect(body["error"]).to be_present
      end
    end
  end
end
