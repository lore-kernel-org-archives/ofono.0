Content-Type: multipart/mixed; boundary="===============9080322115652251652=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Telit driver implementation
Date: Tue, 16 Sep 2014 11:16:51 +0200
Message-ID: <CAH4ZQwuiA7WpsGLBo_yvtumXR_8Phw6k5MWu-u2x0BXPWztrDQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9080322115652251652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear all,
I need to use ofono on a Telit module (UE910). I tried to use he910 plugin
and atmodem driver and it seems to recognize the modem but, some of the
interfaces does not work and I also need some more commands than the one
exported by atmodem.
This request is to ask what should I do? I'm currently starting to develop
a new driver (telitmodem) with the interfaces I need.
Is my behavior correct?

Thank you for any suggestion.
=E2=80=8BRegards=E2=80=8B

Enrico
=E2=80=8B Sau=E2=80=8B

--===============9080322115652251652==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+RGVhciBhbGwsPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SSBuZWVkIHRv
IHVzZSBvZm9ubyBvbiBhIFRlbGl0IG1vZHVsZSAoVUU5MTApLiBJIHRyaWVkIHRvIHVzZSBoZTkx
MCBwbHVnaW4gYW5kIGF0bW9kZW0gZHJpdmVyIGFuZCBpdCBzZWVtcyB0byByZWNvZ25pemUgdGhl
IG1vZGVtIGJ1dCwgc29tZSBvZiB0aGUgaW50ZXJmYWNlcyBkb2VzIG5vdCB3b3JrIGFuZCBJIGFs
c28gbmVlZCBzb21lIG1vcmUgY29tbWFuZHMgdGhhbiB0aGUgb25lIGV4cG9ydGVkIGJ5IGF0bW9k
ZW0uPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZl
cmRhbmEsc2Fucy1zZXJpZiI+VGhpcyByZXF1ZXN0IGlzIHRvIGFzayB3aGF0IHNob3VsZCBJIGRv
PyBJJiMzOTttIGN1cnJlbnRseSBzdGFydGluZyB0byBkZXZlbG9wIGEgbmV3IGRyaXZlciAodGVs
aXRtb2RlbSkgd2l0aCB0aGUgaW50ZXJmYWNlcyBJIG5lZWQuPC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SXMgbXkg
YmVoYXZpb3IgY29ycmVjdD88L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0i
Zm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+VGhhbmsg
eW91IGZvciBhbnkgc3VnZ2VzdGlvbi48L2Rpdj48ZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+4oCLUmVnYXJk
c+KAizwvZGl2Pjxicj48L2Rpdj48ZGl2PkVucmljbzxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQi
IHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWY7ZGlzcGxheTppbmxpbmUiPuKA
iyBTYXXigIs8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj4KPC9kaXY+Cg==

--===============9080322115652251652==--

