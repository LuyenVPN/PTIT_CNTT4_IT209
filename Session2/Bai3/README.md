# Exercise 3 - Nginx Static Website

## 1. Objective

Install and configure Nginx to serve a static website on an EC2 server.

The website displays:

> Welcome to PTIT DevOps Course - Session 02

---

## 2. Environment

- Cloud Provider: AWS EC2
- Operating System: Amazon Linux
- Web Server: Nginx
- HTTP Port: 80
- Public IP: 52.64.126.224

> Note: The assignment specifies Ubuntu/Droplet, but the actual lab environment uses Amazon Linux on AWS EC2.

---

## 3. Install Nginx

Install Nginx:

```bash
sudo dnf install nginx -y
```

Start Nginx:

```bash
sudo systemctl start nginx
```

Enable Nginx at boot:

```bash
sudo systemctl enable nginx
```

Check Nginx status:

```bash
sudo systemctl status nginx --no-pager
```

Expected:

```text
Active: active (running)
```

---

## 4. Create Website Directory

Create the required directory:

```bash
sudo mkdir -p /var/www/ptit-web/html
```

Create the website:

```bash
sudo nano /var/www/ptit-web/html/index.html
```

The page displays:

```text
Welcome to PTIT DevOps Course - Session 02
```

---

## 5. Configure Nginx

Create the configuration directory:

```bash
sudo mkdir -p /etc/nginx/sites-available
sudo mkdir -p /etc/nginx/sites-enabled
```

Create:

```text
/etc/nginx/sites-available/ptit-web.conf
```

Configuration:

```nginx
server {
    listen 80;
    listen [::]:80;

    server_name _;

    root /var/www/ptit-web/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

Enable the site:

```bash
sudo ln -s /etc/nginx/sites-available/ptit-web.conf /etc/nginx/sites-enabled/ptit-web.conf
```

Configure Nginx to load the `sites-enabled` directory:

```nginx
include /etc/nginx/sites-enabled/*.conf;
```

The include directive is placed inside the `http` block of:

```text
/etc/nginx/nginx.conf
```

The default Nginx server block was disabled so that the PTIT website configuration is used.

---

## 6. Test Nginx Configuration

Run:

```bash
sudo nginx -t
```

Result:

```text
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

Reload Nginx:

```bash
sudo systemctl reload nginx
```

---

## 7. Verify Website Locally

Run:

```bash
curl -s http://localhost | grep "Welcome"
```

Expected:

```html
<h1>Welcome to PTIT DevOps Course - Session 02</h1>
```

---

## 8. Verify Nginx Port

Check port 80:

```bash
sudo ss -lntp | grep ':80'
```

Expected:

```text
0.0.0.0:80
[::]:80
```

---

## 9. AWS Security Group

Allow inbound HTTP traffic:

```text
Protocol: TCP
Port: 80
Source: 0.0.0.0/0
```

The website can then be accessed through:

```text
http://52.64.126.224
```

---

## 10. Result

The static website was successfully deployed using Nginx.

URL:

```text
http://52.64.126.224
```

Displayed content:

```text
Welcome to PTIT DevOps Course - Session 02
```

---
