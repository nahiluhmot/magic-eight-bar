# This middleware serializes JSON requests and deserializes JSON responses.
class PlacesAPI::Middleware::JSON < Excon::Middleware::Base
  # When the 'Content-Type' is 'application/json', turn the body into JSON.
  def request_call(datum)
    when_json(datum) { datum[:body] = datum[:body].to_json }

    @stack.request_call(datum)
  end

  # When the 'Content-Type' is 'application/json', turn the body into a Mash or
  # a list of Mashes.
  def response_call(datum)
    when_json(datum[:response]) do
      datum[:response][:body] = mashify(::JSON.parse(datum[:response][:body]))
    end

    @stack.response_call(datum)
  end

  private

  def when_json(datum, &block)
    if datum.has_key?(:headers)
      if datum[:headers].has_key?('Content-Type')
        if datum[:headers]['Content-Type'].start_with?('application/json')
          if !datum[:body].nil?
            block.call(datum)
          end
        end
      end
    end
  end

  def mashify(body)
    case body
    when Hash
      Hashie::Mash.new(body)
    when Array
      body.map { |value| mashify(value) }
    else
      body
    end
  end
end
