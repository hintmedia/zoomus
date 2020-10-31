# frozen_string_literal: true

module Zoom
  module Actions
    module Webinar
      RECURRENCE_KEYS = %i[type repeat_interval weekly_days monthly_day monthly_week
                           monthly_week_day end_times end_date_time].freeze
      SETTINGS_KEYS = %i[host_video panelists_video practice_session hd_video approval_type
                         registration_type audio auto_recording enforce_login
                         enforce_login_domains alternative_hosts close_registration
                         show_share_button allow_multiple_devices on_demand
                         request_permission_to_unmute_participants global_dial_in_countries
                         contact_name contact_email registrants_restrict_number
                         post_webinar_survey survey_url registrants_email_notification
                         meeting_authentication authentication_option
                         authentication_domains registrants_confirmation_email question_answer].freeze
      def webinar_list(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:host_id).permit(%i[page_size page_number])
        Utils.parse_response self.class.get("/users/#{params[:host_id]}/webinars", query: params.except(:host_id), headers: request_headers)
      end

      def webinar_create(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:host_id).permit(:topic, :type, :start_time, :duration,
                                        :timezone, :password, :agenda,
                                        recurrence: RECURRENCE_KEYS,
                                        settings: SETTINGS_KEYS)
        # TODO: process recurrence keys based on constants
        # TODO: process settings keys based on constants
        Utils.parse_response self.class.post("/users/#{params[:host_id]}/webinars", body: params.except(:host_id).to_json, headers: request_headers)
      end

      def webinar_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:id)
        Utils.parse_response self.class.get("/webinars/#{params[:id]}", headers: request_headers)
      end

      def webinar_update(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:id).permit(:topic, :type, :start_time, :duration,
                                   :timezone, :password, :agenda,
                                   recurrence: RECURRENCE_KEYS,
                                   settings: SETTINGS_KEYS)
        Utils.parse_response self.class.patch("/webinars/#{params[:id]}", body: params.except(:id).to_json, headers: request_headers)
      end

      def webinar_delete(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:id).permit(:occurrence_id)
        Utils.parse_response self.class.delete("/webinars/#{params[:id]}", query: params.except(:id), headers: request_headers)
      end

      def webinar_registrants_list(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:id).permit(%i[occurrence_id status page_size page_number])
        Utils.parse_response self.class.get("/webinars/#{params[:id]}/registrants", query: params.except(:id), headers: request_headers)
      end

      def webinar_registrant_add(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[id email first_name last_name])
              .permit(%i[occurrence_ids address city country zip state phone
                         industry org job_title purchasing_time_frame role_in_purchase_process
                         no_of_employees comments custom_questions])
        Utils.parse_response self.class.post("/webinars/#{params[:id]}/registrants", body: params.except(:id, :occurrence_ids).to_json, query: params.slice(:occurrence_ids), headers: request_headers)
      end

      def webinar_registrants_status_update(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[id action])
              .permit(:occurrence_id, registrants: [])
        Utils.parse_response self.class.put("/webinars/#{params[:id]}/registrants/status", body: params.except(:id, :occurrence_id).to_json, query: params.slice(:occurrence_id), headers: request_headers)
      end

      def past_webinar_list(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:id)
        Utils.parse_response self.class.get("/past_webinars/#{params[:id]}/instances", headers: request_headers)
      end

      def webinar_registrant_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[webinar_id id]).permit(:occurrence_id)
        Utils.parse_response self.class.get("/webinars/#{params[:webinar_id]}/registrants/#{params[:id]}", query: params.except(:webinar_id, :id), headers: request_headers)
      end

      def webinar_panelist_list(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:webinar_id)
        Utils.parse_response self.class.get("/webinars/#{params[:webinar_id]}/panelists", headers: request_headers)
      end
    end
  end
end
