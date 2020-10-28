# frozen_string_literal: true

module Zoom
  module Actions
    module Recording
      RECORDING_SETTINGS_KEYS = %i[share_recording recording_authentication
                                   authentication_option authentication_domains viewer_download password
                                   on_demand approval_type send_email_to_host show_social_share_buttons].freeze

      def recording_list(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(:user_id)
        Utils.process_datetime_params!(%i[from to], options)
        Utils.parse_response self.class.get("/users/#{options[:user_id]}/recordings", query: options.except(:user_id), headers: request_headers)
      end

      def meeting_recording_get(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(:meeting_id)
        Utils.parse_response self.class.get("/meetings/#{options[:meeting_id]}/recordings/settings", query: options.except(:meeting_id), headers: request_headers)
      end

      def meeting_recording_settings_get(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(:meeting_id)
        Utils.parse_response self.class.get("/meetings/#{options[:meeting_id]}/recordings/settings", query: options.except(:meeting_id), headers: request_headers)
      end

      def meeting_recording_settings_update(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(:meeting_id).permit(RECORDING_SETTINGS_KEYS)
        Utils.parse_response self.class.patch("/meetings/#{options[:meeting_id]}/recordings/settings", body: options.except(:meeting_id).to_json, headers: request_headers)
      end

      def meeting_recording_file_delete(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(%i[meeting_id recording_id])
        Utils.parse_response self.class.delete("/meetings/#{options[:meeting_id]}/recordings/#{options[:recording_id]}",  query: options.except(:meeting_id, :recording_id), headers: request_headers)
      end
    end
  end
end
