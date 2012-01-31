module InspectPartials
  class RackHandler
    def initialize app
      @app = app
    end

    def call env
      status, headers, response = @app.call(env)
      new_response = transform_response(response)
      new_headers = transform_headers(new_response, headers)
      [status, new_headers, new_response]
    end

    private
    def transform_response response
      source = ""
      response.each {|_| source << _}
      source.blank? ? response : [add_stylesheet(source)]
    end

    def transform_headers(response, headers)
      length = 0
      response.each {|_| length += _.size}
      headers.has_key?('Content-Length') ? headers.merge('Content-Length' => length.to_s) : headers
    end

    def add_stylesheet source
      head_open = source.index("<head")
      return source unless head_open

      head_pos = source.index(">", head_open) + 1
      return source unless head_pos

      source.insert(head_pos, stylesheet_tag)
    end

    def stylesheet_tag
      %q{<link href="/assets/inspect_partials/inspect_partials.css" media="screen" rel="stylesheet" type="text/css"/>}
    end
  end
end
