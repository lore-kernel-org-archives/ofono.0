Content-Type: multipart/mixed; boundary="===============0236210501576797402=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: Alcatel Onetouch X515 support
Date: Thu, 08 Nov 2012 16:29:58 +0100
Message-ID: <CABvLYuCg20pYAfkLmaAMFDJO8u6xpvX=gC2mfm9228_iGruQEA@mail.gmail.com>
In-Reply-To: <509BCB6F.40102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0236210501576797402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>
> The design philosophy is to not perform any polling in the core.  The
> modem driver has to take care of this.
>

Ok. So in case of the atmodem driver, would it be correct to move this
retrying of AT+CPIN? to at_cpin_cb and only call the cb from the core once
the reply is not CME Error SIM Busy?

Thanks,
Cedric

--===============0236210501576797402==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7
Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7
Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBjbGFzcz0iaW0i
PgpUaGUgZGVzaWduIHBoaWxvc29waHkgaXMgdG8gbm90IHBlcmZvcm0gYW55IHBvbGxpbmcgaW4g
dGhlIGNvcmUuIKBUaGUgbW9kZW0gZHJpdmVyIGhhcyB0byB0YWtlIGNhcmUgb2YgdGhpcy48L2Rp
dj48L2Jsb2NrcXVvdGU+PGRpdj6gPC9kaXY+PC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZXh0cmEiPk9rLiBTbyBpbiBjYXNlIG9mIHRoZSBhdG1vZGVtIGRyaXZlciwgd291bGQgaXQgYmUg
Y29ycmVjdCB0byBtb3ZlIHRoaXMgcmV0cnlpbmcgb2YgQVQrQ1BJTj8gdG8gYXRfY3Bpbl9jYiBh
bmQgb25seSBjYWxsIHRoZSBjYiBmcm9tIHRoZSBjb3JlIG9uY2UgdGhlIHJlcGx5IGlzIG5vdCBD
TUUgRXJyb3IgU0lNIEJ1c3k/PC9kaXY+CjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPlRoYW5rcyw8L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9leHRyYSI+Q2VkcmljPC9kaXY+Cg==

--===============0236210501576797402==--

