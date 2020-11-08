# frozen_string_literal: true

module Zoom
  module Actions
    module Groups
      def groups_list(*_args)
        Utils.parse_response self.class.get('/groups', headers: request_headers)
      end

      def groups_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:group_id)
        Utils.parse_response self.class.get("/groups/#{params[:group_id]}", headers: request_headers)
      end
    end
  end
end