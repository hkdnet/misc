import os
from http.server import HTTPServer, SimpleHTTPRequestHandler


class MyHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        # デフォだとファイルツリー表示が始まるので潰しておく
        self.__write_400()

    def do_POST(self):
        if not self.__authorize():
            self.__write_400()
            return

        content_len = int(self.headers.get('content-length', 0))
        # バイナリでbodyを取得
        b_req_body = self.rfile.read(content_len)

        # なんか処理する
        b_resp = b_req_body

        self.__write_200(b_resp)

    def __write_200(self, response_body):
        self.send_response(200)
        self.send_header('Content-type', 'text/html; charset=utf-8')
        self.send_header('Content-length', len(response_body))
        self.end_headers()
        self.wfile.write(response_body)

    def __write_400(self):
        self.send_response(400)
        self.end_headers()

    def __authorize(self):
        # 適当に認証しとく
        token = self.headers.get('Authorization')
        return token == "Bearer YOUR_TOKEN"


def run(port):
    host = '0.0.0.0'
    httpd = HTTPServer((host, port), MyHandler)
    httpd.serve_forever()


if __name__ == '__main__':
    if "PORT" in os.environ:
        port = int(os.environ["PORT"])
    else:
        port = 8000  # default

    run(port)
