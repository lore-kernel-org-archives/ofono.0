Content-Type: multipart/mixed; boundary="===============5711804931176126505=="
MIME-Version: 1.0
From: Pargada, Carlos <carlos.pargada@intel.com>
Subject: [PATCH] Fix IFX large file Downlink data transer
Date: Thu, 20 Jan 2011 10:37:25 +0000
Message-ID: <2A84145621092446B6659B8A0F28E26F47006AA770@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5711804931176126505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatio.c b/gatchat/gatio.c
index 9cfc998..9d44a78 100644
--- a/gatchat/gatio.c
+++ b/gatchat/gatio.c
@@ -197,7 +197,7 @@ static GAtIO *create_io(GIOChannel *channel, GIOFlags f=
lags)
                               io->use_write_watch =3D FALSE;
                }

-              io->buf =3D ring_buffer_new(4096);
+             io->buf =3D ring_buffer_new(8192);

                if (!io->buf)
                               goto error;
@@ -288,7 +288,7 @@ gboolean g_at_io_set_write_handler(GAtIO *io, GAtIOWrit=
eFunc write_handler,

                if (io->use_write_watch =3D=3D TRUE)
                               io->write_watch =3D g_io_add_watch_full(io->=
channel,
-                                                             G_PRIORITY_DE=
FAULT,
+                                                            G_PRIORITY_HIG=
H,
                                                               G_IO_OUT | G=
_IO_HUP | G_IO_ERR | G_IO_NVAL,
                                                               can_write_da=
ta, io,
                                                               write_watche=
r_destroy_notify);
--
1.6.6.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5711804931176126505==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+Cgo8aGVhZD4KPG1ldGEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29u
dGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXVzLWFzY2lpIj4KPG1ldGEgbmFtZT1HZW5lcmF0b3Ig
Y29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTIgKGZpbHRlcmVkIG1lZGl1bSkiPgo8c3R5bGU+Cjwh
LS0KIC8qIEZvbnQgRGVmaW5pdGlvbnMgKi8KIEBmb250LWZhY2UKCXtmb250LWZhbWlseToiQ2Ft
YnJpYSBNYXRoIjsKCXBhbm9zZS0xOjIgNCA1IDMgNSA0IDYgMyAyIDQ7fQpAZm9udC1mYWNlCgl7
Zm9udC1mYW1pbHk6Q2FsaWJyaTsKCXBhbm9zZS0xOjIgMTUgNSAyIDIgMiA0IDMgMiA0O30KIC8q
IFN0eWxlIERlZmluaXRpb25zICovCiBwLk1zb05vcm1hbCwgbGkuTXNvTm9ybWFsLCBkaXYuTXNv
Tm9ybWFsCgl7bWFyZ2luOjBjbTsKCW1hcmdpbi1ib3R0b206LjAwMDFwdDsKCWZvbnQtc2l6ZTox
MS4wcHQ7Cglmb250LWZhbWlseToiQ2FsaWJyaSIsInNhbnMtc2VyaWYiO30KYTpsaW5rLCBzcGFu
Lk1zb0h5cGVybGluawoJe21zby1zdHlsZS1wcmlvcml0eTo5OTsKCWNvbG9yOmJsdWU7Cgl0ZXh0
LWRlY29yYXRpb246dW5kZXJsaW5lO30KYTp2aXNpdGVkLCBzcGFuLk1zb0h5cGVybGlua0ZvbGxv
d2VkCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5OwoJY29sb3I6cHVycGxlOwoJdGV4dC1kZWNvcmF0
aW9uOnVuZGVybGluZTt9CnNwYW4uRW1haWxTdHlsZTE3Cgl7bXNvLXN0eWxlLXR5cGU6cGVyc29u
YWwtY29tcG9zZTsKCWZvbnQtZmFtaWx5OiJDYWxpYnJpIiwic2Fucy1zZXJpZiI7Cgljb2xvcjp3
aW5kb3d0ZXh0O30KLk1zb0NocERlZmF1bHQKCXttc28tc3R5bGUtdHlwZTpleHBvcnQtb25seTt9
CkBwYWdlIFdvcmRTZWN0aW9uMQoJe3NpemU6NjEyLjBwdCA3OTIuMHB0OwoJbWFyZ2luOjcwLjg1
cHQgNzAuODVwdCA3MC44NXB0IDcwLjg1cHQ7fQpkaXYuV29yZFNlY3Rpb24xCgl7cGFnZTpXb3Jk
U2VjdGlvbjE7fQotLT4KPC9zdHlsZT4KPCEtLVtpZiBndGUgbXNvIDldPjx4bWw+CiA8bzpzaGFw
ZWRlZmF1bHRzIHY6ZXh0PSJlZGl0IiBzcGlkbWF4PSIxMDI2IiAvPgo8L3htbD48IVtlbmRpZl0t
LT48IS0tW2lmIGd0ZSBtc28gOV0+PHhtbD4KIDxvOnNoYXBlbGF5b3V0IHY6ZXh0PSJlZGl0Ij4K
ICA8bzppZG1hcCB2OmV4dD0iZWRpdCIgZGF0YT0iMSIgLz4KIDwvbzpzaGFwZWxheW91dD48L3ht
bD48IVtlbmRpZl0tLT4KPC9oZWFkPgoKPGJvZHkgbGFuZz1GUiBsaW5rPWJsdWUgdmxpbms9cHVy
cGxlPgoKPGRpdiBjbGFzcz1Xb3JkU2VjdGlvbjE+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PHNwYW4g
bGFuZz1FTi1VUz4tLS08bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+
PHNwYW4gbGFuZz1FTi1VUz4mbmJzcDtnYXRjaGF0L2dhdGlvLmMgfCZuYnNwOyZuYnNwOyZuYnNw
OyA0CisrLS08bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PHNwYW4g
bGFuZz1FTi1VUz4mbmJzcDsxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMgpkZWxl
dGlvbnMoLSk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PHNwYW4g
bGFuZz1FTi1VUz48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3Jt
YWw+PHNwYW4gbGFuZz1FTi1VUz5kaWZmIC0tZ2l0IGEvZ2F0Y2hhdC9nYXRpby5jCmIvZ2F0Y2hh
dC9nYXRpby5jPG86cD48L286cD48L3NwYW4+PC9wPgoKPHAgY2xhc3M9TXNvTm9ybWFsPjxzcGFu
IGxhbmc9RU4tVVM+aW5kZXggOWNmYzk5OC4uOWQ0NGE3OCAxMDA2NDQ8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PHNwYW4gbGFuZz1FTi1VUz4tLS0gYS9nYXRjaGF0
L2dhdGlvLmM8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PHNwYW4g
bGFuZz1FTi1VUz4rKysgYi9nYXRjaGF0L2dhdGlvLmM8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cgo8
cCBjbGFzcz1Nc29Ob3JtYWw+PHNwYW4gbGFuZz1FTi1VUz5AQCAtMTk3LDcgKzE5Nyw3IEBAIHN0
YXRpYyBHQXRJTwoqY3JlYXRlX2lvKEdJT0NoYW5uZWwgKmNoYW5uZWwsIEdJT0ZsYWdzIGZsYWdz
KTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KCjxwIGNsYXNzPU1zb05vcm1hbD48c3BhbiBsYW5nPUVO
LVVTPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBpby0mZ3Q7dXNlX3dyaXRlX3dhdGNoCj0gRkFMU0U7PG86cD48L286cD48
L3NwYW4+PC9wPgoKPHAgY2xhc3M9TXNvTm9ybWFsPjxzcGFuIGxhbmc9RU4tVVM+Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cgo8cCBjbGFz
cz1Nc29Ob3JtYWw+PHNwYW4gbGFuZz1FTi1VUz4mbmJzcDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+
Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PHNwYW4gbGFuZz1FTi1VUz4tJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IGlvLSZndDtidWYKPSByaW5nX2J1ZmZlcl9uZXcoNDA5Nik7PG86cD48L286cD48L3NwYW4+
PC9wPgoKPHAgY2xhc3M9TXNvTm9ybWFsPjxzcGFuIGxhbmc9RU4tVVM+KyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBpby0mZ3Q7YnVmCj0gcmluZ19idWZmZXJfbmV3KDgxOTIpOzxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4KCjxwIGNsYXNzPU1zb05vcm1hbD48c3BhbiBsYW5nPUVOLVVTPiZuYnNwOzxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4KCjxwIGNsYXNzPU1zb05vcm1hbD48c3BhbiBsYW5nPUVOLVVTPiZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZgooIWlvLSZndDtidWYpPG86cD48L286cD48L3Nw
YW4+PC9wPgoKPHAgY2xhc3M9TXNvTm9ybWFsPjxzcGFuIGxhbmc9RU4tVVM+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdv
dG8KZXJyb3I7PG86cD48L286cD48L3NwYW4+PC9wPgoKPHAgY2xhc3M9TXNvTm9ybWFsPjxzcGFu
IGxhbmc9RU4tVVM+QEAgLTI4OCw3ICsyODgsNyBAQCBnYm9vbGVhbgpnX2F0X2lvX3NldF93cml0
ZV9oYW5kbGVyKEdBdElPICppbywgR0F0SU9Xcml0ZUZ1bmMgd3JpdGVfaGFuZGxlciw8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PHNwYW4gbGFuZz1FTi1VUz4mbmJz
cDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PHNwYW4gbGFuZz1F
Ti1VUz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYKKGlvLSZndDt1c2Vfd3Jp
dGVfd2F0Y2ggPT0gVFJVRSk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3Jt
YWw+PHNwYW4gbGFuZz1FTi1VUz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaW8tJmd0O3dyaXRlX3dhdGNoCj0gZ19pb19h
ZGRfd2F0Y2hfZnVsbChpby0mZ3Q7Y2hhbm5lbCw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cgo8cCBj
bGFzcz1Nc29Ob3JtYWw+PHNwYW4gbGFuZz1FTi1VUz4tJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEdfUFJJ
T1JJVFlfREVGQVVMVCw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+
PHNwYW4gbGFuZz1FTi1VUz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEdfUFJJT1JJVFlfSElHSCw8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PHNwYW4gbGFuZz1FTi1VUz4mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgR19JT19PVVQKfCBHX0lPX0hVUCB8IEdfSU9fRVJSIHwg
R19JT19OVkFMLDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KCjxwIGNsYXNzPU1zb05vcm1hbD48c3Bh
biBsYW5nPUVOLVVTPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjYW5fd3JpdGVfZGF0
YSwKaW8sPG86cD48L286cD48L3NwYW4+PC9wPgoKPHAgY2xhc3M9TXNvTm9ybWFsPjxzcGFuIGxh
bmc9RU4tVVM+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHdyaXRlX3dhdGNoZXJfZGVz
dHJveV9ub3RpZnkpOzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4KCjxwIGNsYXNzPU1zb05vcm1hbD4t
LSA8bzpwPjwvbzpwPjwvcD4KCjxwIGNsYXNzPU1zb05vcm1hbD4xLjYuNi4xPG86cD48L286cD48
L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PG86cD4mbmJzcDs8L286cD48L3A+Cgo8L2Rpdj4KCjxm
b250IGZhY2U9Im1vbm9zcGFjZSI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgpJbnRlbCBDb3Jwb3JhdGlvbiBT
QVMgKEZyZW5jaCBzaW1wbGlmaWVkIGpvaW50IHN0b2NrIGNvbXBhbnkpPGJyPgpSZWdpc3RlcmVk
IGhlYWRxdWFydGVyczogIkxlcyBNb250YWxldHMiLSAyLCBydWUgZGUgUGFyaXMsIDxicj4KOTIx
OTYgTWV1ZG9uIENlZGV4LCBGcmFuY2U8YnI+ClJlZ2lzdHJhdGlvbiBOdW1iZXI6Jm5ic3A7IDMw
MiA0NTYgMTk5IFIuQy5TLiBOQU5URVJSRTxicj4KQ2FwaXRhbDogNCw1NzIsMDAwIEV1cm9zPGJy
Pgo8YnI+ClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlk
ZW50aWFsIG1hdGVyaWFsIGZvcjxicj4KdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNp
cGllbnQocykuIEFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uPGJyPgpieSBvdGhlcnMgaXMgc3Ry
aWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkPGJyPgpyZWNpcGll
bnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzLjwvZm9u
dD48L2JvZHk+Cgo8L2h0bWw+Cg==

--===============5711804931176126505==--

