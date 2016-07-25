Content-Type: multipart/mixed; boundary="===============2464608822352987818=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: How to port Telit LE910V2 module
Date: Mon, 25 Jul 2016 10:19:21 +0200
Message-ID: <CAH4ZQwvUj46bP66u7LL5c_pctsF8wHUu_fiKAu9N999YhYLD+w@mail.gmail.com>
In-Reply-To: <loom.20160725T082756-821@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2464608822352987818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ashida,

are you using ofono internal ppp management?
in this case, as far as I know, it should work with standard commands:

sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);

You may have some problems in using the correct context number, but this is
a later problem.

Enrico

--===============2464608822352987818==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SGkgQXNoaWRhLDwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPjxicj48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxz
YW5zLXNlcmlmIj5hcmUgeW91IHVzaW5nIG9mb25vIGludGVybmFsIHBwcCBtYW5hZ2VtZW50Pzwv
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5h
LHNhbnMtc2VyaWYiPmluIHRoaXMgY2FzZSwgYXMgZmFyIGFzIEkga25vdywgaXQgc2hvdWxkIHdv
cmsgd2l0aCBzdGFuZGFyZCBjb21tYW5kczo8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0
IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48YnI+PC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJp
ZiI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+c3ByaW50ZihidWYsICZxdW90O0FUK0NHREFU
QT1cJnF1b3Q7UFBQXCZxdW90OywldSZxdW90OywgZ2NkLSZndDthY3RpdmVfY29udGV4dCk7PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Zb3UgbWF5IGhhdmUgc29tZSBwcm9ibGVtcyBpbiB1c2lu
ZyB0aGUgY29ycmVjdCBjb250ZXh0IG51bWJlciwgYnV0IHRoaXMgaXMgYSBsYXRlciBwcm9ibGVt
LjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWls
eTp2ZXJkYW5hLHNhbnMtc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0
IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5FbnJpY288L2Rpdj48L2Rp
dj4K

--===============2464608822352987818==--

