require 'rails_helper'

module Peephole
  RSpec.describe LogfilesController, type: :controller do
    render_views
    routes { Engine.routes }

    let(:filename) { 'test.log.1' }
    let(:page) { nil }

    shared_examples_for 'show logfile' do
      before do
        get action, id: filename, page: page
      end
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      it 'assings logfile' do
        expect(assigns(:logfile).filename).to eq(filename)
      end
    end

    describe '#show' do
      let(:action) { :show }
      context 'without params' do
        it_behaves_like 'show logfile'
      end
      context 'with page' do
        let(:page) { 2 }
        it_behaves_like 'show logfile'
      end
      context 'when file is gz' do
        let(:filename) { 'test.log.2.gz' }
        it_behaves_like 'show logfile'
      end
    end

    describe '#raw' do
      let(:action) { :raw }
      context 'without params' do
        it_behaves_like 'show logfile'
      end
      context 'with page' do
        let(:page) { 2 }
        it_behaves_like 'show logfile'
      end
      context 'when file is gz' do
        let(:filename) { 'test.log.2.gz' }
        it_behaves_like 'show logfile'
      end
    end

    describe '#download' do
      before do
        get :download, id: filename
      end
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      it 'sends log file' do
        expect(response.body).to eq(File.read(Rails.root.join('log', filename)))
      end
    end
  end
end
