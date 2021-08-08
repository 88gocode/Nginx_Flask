# Nginx_Flask
通常將寫好的**Python Flask**運行起來,可以使用Flask自帶web server來執行測試,或是使用**Nginx + uwsgi**等方式測試。
為了方便部屬及測試,本篇使用**Nginx + uwsgi**包成container 在Docker 平台上運作。

## How to work
### 直接執行測試
```bash=
docker run -d -p 8080:80 --name labtest1 alicode/uwsgilab2

curl 127.0.0.1:8080
curl 127.0.0.1:8080/home
```
###  另一種情況,寫好的Python Flask 餵給 alicode/uwsgilab2 測試
例如有一個Python Flask 程式位於 **/tmp/Flask-LAB/**, 裡面有一個 index.py /tmp/Flask-LAB/index.py
```bash=
mkdir /tmp/Flask-LAB
touch /tmp/Flask-LAB/index.py
```

/tmp/Flask-LAB/index.py
```python=
#!/usr/bin/env python3
from flask import Flask
app = Flask(__name__)
@app.route('/')
def index():
    return "<h1>Welcom to My Web Site</h1>"

if  __name__ == '__main__':
    app.run(host='127.0.0.1',port=8099,debug=True)
```
uwsgi 設定檔: /tmp/Flask-LAB/uwsgi.ini
通常只要修正主程式進入點,此範例 /tmp/Flask-LAB/index.py  **module = index**;
```
[uwsgi]
socket = 127.0.0.1:8091
uid = nginx
gid = nginx
die-on-term = true
chdir = /var/www/html/WebPython/
module = index
callable = app
master = true
workers = 2
reload-mercy = 5
max-requests = 30
pidfile = /var/run/uwsgi8091.pid
daemonize = /var/log/uwsgi8091.log
```
執行 container
```bash=
docker run -d -p 8080:80 --name labtest1 -v /tmp/Flask-LAB/:/var/www/html/WebPython/  alicode/uwsgilab2
```
測試
```bash=
curl 127.0.0.1:8080
```
## How to rebuild image
- 下載此源碼,依照自己需求增刪改
```bash=
cd /tmp/
git clone https://github.com/88gocode/Nginx_Flask.git
```

- 執行 rebuild
```bash=
cd /tmp/Nginx_Flask
docker build -t myimages:v1 .
```
