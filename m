Content-Type: multipart/mixed; boundary="===============7150745686374412844=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: [PATCH 1/2] Telit HE910 general fixes for gprs, sms and voicecall
Date: Fri, 13 Mar 2015 11:02:10 +0100
Message-ID: <CAH4ZQwvn13yofo=na=m_JyhJsqDsREbm3U+Uv-X_O0Z2jOXcfQ@mail.gmail.com>
In-Reply-To: <5501C54A.8090108@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7150745686374412844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

In official AT command reference for HE910 is stated that CFUN=3D4 turns the
SIM off.
Then, I made the CFUN=3D4 trick to handle situations where ofono was sterted
with the modem already ON.
I understand this is not a normal situation anyway.

I will resubmit the patches with git send mail and without these "custom
tricks".

Thank you.

Enrico

--===============7150745686374412844==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SGkgRGVuaXMsPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+PGJyPjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNh
bnMtc2VyaWYiPkluIG9mZmljaWFsIEFUIGNvbW1hbmQgcmVmZXJlbmNlIGZvciBIRTkxMCBpcyBz
dGF0ZWQgdGhhdCBDRlVOPTQgdHVybnMgdGhlIFNJTSBvZmYuPC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+VGhlbiwg
SSBtYWRlIHRoZSBDRlVOPTQgdHJpY2sgdG8gaGFuZGxlIHNpdHVhdGlvbnMgd2hlcmUgb2Zvbm8g
d2FzIHN0ZXJ0ZWQgd2l0aCB0aGUgbW9kZW0gYWxyZWFkeSBPTi48L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5JIHVu
ZGVyc3RhbmQgdGhpcyBpcyBub3QgYSBub3JtYWwgc2l0dWF0aW9uIGFueXdheS48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNl
cmlmIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SSB3aWxsIHJlc3VibWl0IHRoZSBwYXRjaGVzIHdpdGgg
Z2l0IHNlbmQgbWFpbCBhbmQgd2l0aG91dCB0aGVzZSAmcXVvdDtjdXN0b20gdHJpY2tzJnF1b3Q7
LjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJk
YW5hLHNhbnMtc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHls
ZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5UaGFuayB5b3UuPC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZXh0cmEiPjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkVucmljbzwvZGl2PjwvZGl2PjwvZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============7150745686374412844==--

