module LabsLogo
  JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json' }

  describe App do
    it 'redirects to /logo' do
      get '/'
      expect(last_response).to be_redirect
      follow_redirect!

      expect(last_request.url).to eq('http://example.org/logo')
    end

    it 'redirects to a logo as SVG' do
      get '/logo.svg'
      expect(last_response).to be_redirect
      follow_redirect!

      expect(last_request.url).to match(/\/assets\/odilabs\-/)
    end

    it 'shows the logo as HTML' do
      get '/logo'
      expect(last_response).to be_ok
      expect(last_response.body).to match /<img src="\/logo.svg" alt="ODI Labs Logo" \/>/
    end

    it 'serves JSON for some reason' do
      get '/logo', nil, JSON_HEADERS
      expect(last_response).to be_ok
      json = JSON.parse last_response.body
      expect(json['logo']).to_not be_nil
    end

    it 'returns the right image type for a dark background' do
      allow_any_instance_of(Object).to receive(:rand) { 8 }
      get '/logo.svg?bg=dark'
      expect(last_response).to be_redirect
      follow_redirect!

      expect(last_request.url).to eq('http://example.org/assets/odilabs-8-dark.svg')
    end

    it 'defaults to a light background' do
      allow_any_instance_of(Object).to receive(:rand) { 8 }
      get '/logo.svg'
      expect(last_response).to be_redirect
      follow_redirect!

      expect(last_request.url).to eq('http://example.org/assets/odilabs-8-light.svg')
    end
  end
end
