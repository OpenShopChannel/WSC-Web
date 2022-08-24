from http.server import BaseHTTPRequestHandler

# Preserve the original function.
original_send_header = BaseHTTPRequestHandler.send_header


def no_close_header(self, keyword, value):
    """If the header keyword is 'Connection', obliterate.

    Opera on the Wii does not support Connection: close, for
    unknown reasons. Hours of debugging landed on this issue.
    This should likely be eventually removed in favor of not
    allowing this project to be started with HTTPS directly,
    and enforcing another HTTP server (such as nginx)
    to proxy it."""
    if keyword == "Connection" and value == "close":
        return

    original_send_header(self, keyword, value)


# Replace.
BaseHTTPRequestHandler.send_header = no_close_header
