// CloudFront viewer-request function (cloudfront-js-2.0).
// - Redirects www.<domain> to <domain>
// - Serves Jekyll "pretty" URLs: /about/ and /about -> /about/index.html
function handler(event) {
  var request = event.request;
  var host = request.headers.host ? request.headers.host.value : "";

  if (host.startsWith("www.")) {
    return {
      statusCode: 301,
      statusDescription: "Moved Permanently",
      headers: { location: { value: "https://" + host.slice(4) + request.uri } },
    };
  }

  var uri = request.uri;
  if (uri.endsWith("/")) {
    request.uri = uri + "index.html";
  } else if (!uri.split("/").pop().includes(".")) {
    request.uri = uri + "/index.html";
  }
  return request;
}
