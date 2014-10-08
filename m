Content-Type: multipart/mixed; boundary="===============3733586023482998041=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: Unable to get network interface working
Date: Wed, 08 Oct 2014 16:50:10 +0200
Message-ID: <CAH4ZQwsFW5nvNVi01MWZErz+EaJjvhGVej_ZNDQaUuL6kS=6_Q@mail.gmail.com>
In-Reply-To: <542EB282.2060007@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3733586023482998041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>
> oFono understands escape sequences, so #1 is sufficient.  On most hardware
> we can send AT&C0 to disable #2, but some hardware still ignores that.
>
> =E2=80=8B
Thank you so much,
I solved the problem changing the port from "chat" to "modem" for the AT&C0
command in the he910 plugin.
It may be a fix for ofono.

Regards
Enrico Sau=E2=80=8B

--===============3733586023482998041==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LWNvbG9yOnJn
YigyMDQsMjA0LDIwNCk7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+
b0Zvbm8gdW5kZXJzdGFuZHMgZXNjYXBlIHNlcXVlbmNlcywgc28gIzEgaXMgc3VmZmljaWVudC7C
oCBPbiBtb3N0IGhhcmR3YXJlIHdlIGNhbiBzZW5kIEFUJmFtcDtDMCB0byBkaXNhYmxlICMyLCBi
dXQgc29tZSBoYXJkd2FyZSBzdGlsbCBpZ25vcmVzIHRoYXQuPGJyPgo8YnI+PC9ibG9ja3F1b3Rl
PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRh
bmEsc2Fucy1zZXJpZjtkaXNwbGF5OmlubGluZSI+4oCLPC9kaXY+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+VGhhbmsgeW91IHNvIG11Y2gswqA8L3NwYW4+PC9k
aXY+PGRpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVy
ZGFuYSxzYW5zLXNlcmlmO2Rpc3BsYXk6aW5saW5lIj5JIHNvbHZlZCB0aGUgcHJvYmxlbSBjaGFu
Z2luZyB0aGUgcG9ydCBmcm9tICZxdW90O2NoYXQmcXVvdDsgdG8gJnF1b3Q7bW9kZW0mcXVvdDsg
Zm9yIHRoZSBBVCZhbXA7QzAgY29tbWFuZCBpbiB0aGUgaGU5MTAgcGx1Z2luLjwvZGl2PjwvZGl2
PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRh
bmEsc2Fucy1zZXJpZjtkaXNwbGF5OmlubGluZSI+SXQgbWF5IGJlIGEgZml4IGZvciBvZm9uby48
L2Rpdj48L2Rpdj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZh
bWlseTp2ZXJkYW5hLHNhbnMtc2VyaWY7ZGlzcGxheTppbmxpbmUiPjxicj48L2Rpdj48L2Rpdj48
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5h
LHNhbnMtc2VyaWY7ZGlzcGxheTppbmxpbmUiPlJlZ2FyZHM8L2Rpdj48L2Rpdj48ZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2Vy
aWY7ZGlzcGxheTppbmxpbmUiPkVucmljbyBTYXXigIs8L2Rpdj7CoDwvZGl2PjwvZGl2PjwvZGl2
PjwvZGl2Pgo=

--===============3733586023482998041==--

