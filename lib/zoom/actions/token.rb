# frozen_string_literal: true
#
module Zoom
  module Actions
    module Token
      def access_tokens(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(%i[auth_code redirect_uri])
        response = self.class.post("/oauth/token?grant_type=authorization_code&code=#{options[:auth_code]}&redirect_uri=#{options[:redirect_uri]}", headers: oauth_request_headers, base_uri: 'https://zoom.us/')
        Utils.parse_response(response)
      end

      def refresh_tokens(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(:refresh_token)
        response = self.class.post("/oauth/token?grant_type=refresh_token&refresh_token=#{options[:refresh_token]}", headers: oauth_request_headers, base_uri: 'https://zoom.us/')
        Utils.parse_response(response)
      end

      def data_compliance(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(%i[client_id user_id account_id deauthorization_event_received compliance_completed])
        response = self.class.post("/oauth/data/compliance", body: options.to_json, headers: oauth_request_headers, base_uri: 'https://zoom.us/')
        Utils.parse_response response
      end

      def revoke_tokens(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(%i[access_token])
        response = self.class.post("/oauth/revoke?token=#{options[:access_token]}", headers: oauth_request_headers, base_uri: 'https://zoom.us/')
        Utils.parse_response(response)
      end
    end
  end
end
