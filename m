Content-Type: multipart/mixed; boundary="===============4318061558337921528=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: Unable to get network interface working
Date: Fri, 03 Oct 2014 14:40:31 +0200
Message-ID: <CAH4ZQwtdtSyR_Fy8R_dEd-PgGpK+uF+7spUxssF_EcnrMh_fLQ@mail.gmail.com>
In-Reply-To: <CAH4ZQws4isW1sXwBPxmBhB+k_fCSYmz9VRcbpuQYc0xN90FOow@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4318061558337921528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, hi all,

I finally got the network interface working by uninstalling the network
manager and manually setting the ppp0 interface with parameters retrieved
from the modem.

I have another problem:
I start the network interface with activate-context python script, and stop
with deactivate-context script.
Once I call deactivate-context, I'm no more able to activate it because ppp
disconnect function calls io_disconnect method, which clears the at channel.
The only way to resume the ppp connection is to disable and re-enable the
modem in order fot the at channel structures to be filled in again.

Is there any reason for that? Is deactivate-context the correct way to
temporary stop the network?

Thank you.


Enrico

--===============4318061558337921528==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SGkgRGVuaXMsIGhpIGFsbCw8L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48
YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZl
cmRhbmEsc2Fucy1zZXJpZiI+SSBmaW5hbGx5IGdvdCB0aGUgbmV0d29yayBpbnRlcmZhY2Ugd29y
a2luZyBieSB1bmluc3RhbGxpbmcgdGhlIG5ldHdvcmsgbWFuYWdlciBhbmQgbWFudWFsbHkgc2V0
dGluZyB0aGUgcHBwMCBpbnRlcmZhY2Ugd2l0aCBwYXJhbWV0ZXJzIHJldHJpZXZlZCBmcm9tIHRo
ZSBtb2RlbS48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1p
bHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SSBoYXZlIGFub3RoZXIg
cHJvYmxlbTo8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1p
bHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5JIHN0YXJ0IHRoZSBuZXR3b3JrIGludGVyZmFjZSB3aXRo
IGFjdGl2YXRlLWNvbnRleHQgcHl0aG9uIHNjcmlwdCwgYW5kIHN0b3Agd2l0aCBkZWFjdGl2YXRl
LWNvbnRleHQgc2NyaXB0LjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJm
b250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPk9uY2UgSSBjYWxsIGRlYWN0aXZhdGUtY29u
dGV4dCwgSSYjMzk7bSBubyBtb3JlIGFibGUgdG8gYWN0aXZhdGUgaXQgYmVjYXVzZSBwcHAgZGlz
Y29ubmVjdCBmdW5jdGlvbiBjYWxsc8KgaW9fZGlzY29ubmVjdCBtZXRob2QsIHdoaWNoIGNsZWFy
cyB0aGUgYXQgY2hhbm5lbC48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0i
Zm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5UaGUgb25seSB3YXkgdG8gcmVzdW1lIHRo
ZSBwcHAgY29ubmVjdGlvbiBpcyB0byBkaXNhYmxlIGFuZCByZS1lbmFibGUgdGhlIG1vZGVtIGlu
IG9yZGVyIGZvdCB0aGUgYXQgY2hhbm5lbCBzdHJ1Y3R1cmVzIHRvIGJlIGZpbGxlZCBpbiBhZ2Fp
bi48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVy
ZGFuYSxzYW5zLXNlcmlmIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SXMgdGhlcmUgYW55IHJlYXNvbiBm
b3IgdGhhdD8gSXMgZGVhY3RpdmF0ZS1jb250ZXh0IHRoZSBjb3JyZWN0IHdheSB0byB0ZW1wb3Jh
cnkgc3RvcCB0aGUgbmV0d29yaz88L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHls
ZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+VGhh
bmsgeW91LjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnIgY2xlYXI9ImFsbCI+PGRp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PkVucmljbzwvZGl2PjwvZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============4318061558337921528==--

