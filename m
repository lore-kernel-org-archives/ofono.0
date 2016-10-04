Content-Type: multipart/mixed; boundary="===============3487906726676633963=="
MIME-Version: 1.0
From: Antoine Aubert <a.aubert@overkiz.com>
Subject: [PATCH] gatmux: fix channel remove on error.
Date: Tue, 04 Oct 2016 09:42:11 +0200
Message-ID: <413c78b0-58b5-42cc-0d2f-ec0615a83688@overkiz.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3487906726676633963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of invalid IO, read_watch is not reset. Fix crash on destroy
gatmux.

Signed-off-by: Antoine Aubert <a.aubert@overkiz.com>
---
 gatchat/gatmux.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index 9beeece..896ddff 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -186,8 +186,10 @@ static gboolean received_data(GIOChannel *channel, GIO=
Condition cond,
 	GIOStatus status;
 	gsize bytes_read;
 =

-	if (cond & G_IO_NVAL)
+	if (cond & G_IO_NVAL) {
+		mux->read_watch =3D 0;
 		return FALSE;
+	}
 =

 	debug(mux, "received data");
 =

@@ -223,14 +225,20 @@ static gboolean received_data(GIOChannel *channel, GI=
OCondition cond,
 		}
 	}
 =

-	if (cond & (G_IO_HUP | G_IO_ERR))
+	if (cond & (G_IO_HUP | G_IO_ERR)) {
+		mux->read_watch =3D 0;
 		return FALSE;
+	}
 =

-	if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
+	if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN) {
+		mux->read_watch =3D 0;
 		return FALSE;
+	}
 =

-	if (mux->buf_used =3D=3D sizeof(mux->buf))
+	if (mux->buf_used =3D=3D sizeof(mux->buf)) {
+		mux->read_watch =3D 0;
 		return FALSE;
+	}
 =

 	return TRUE;
 }
-- =

2.7.4


--===============3487906726676633963==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CgogICAgPG1ldGEgaHR0cC1lcXVpdj0iY29udGVudC10eXBlIiBjb250
ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPgogIDwvaGVhZD4KICA8Ym9keSBiZ2NvbG9y
PSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4KICAgIDxwcmU+SW4gY2FzZSBvZiBpbnZhbGlkIElP
LCByZWFkX3dhdGNoIGlzIG5vdCByZXNldC4gRml4IGNyYXNoIG9uIGRlc3Ryb3kKZ2F0bXV4LgoK
U2lnbmVkLW9mZi1ieTogQW50b2luZSBBdWJlcnQgPGEgY2xhc3M9Im1vei10eHQtbGluay1yZmMy
Mzk2RSIgaHJlZj0ibWFpbHRvOmEuYXViZXJ0QG92ZXJraXouY29tIj4mbHQ7YS5hdWJlcnRAb3Zl
cmtpei5jb20mZ3Q7PC9hPgotLS0KIGdhdGNoYXQvZ2F0bXV4LmMgfCAxNiArKysrKysrKysrKyst
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9nYXRjaGF0L2dhdG11eC5jIGIvZ2F0Y2hhdC9nYXRtdXguYwppbmRleCA5YmVl
ZWNlLi44OTZkZGZmIDEwMDY0NAotLS0gYS9nYXRjaGF0L2dhdG11eC5jCisrKyBiL2dhdGNoYXQv
Z2F0bXV4LmMKQEAgLTE4Niw4ICsxODYsMTAgQEAgc3RhdGljIGdib29sZWFuIHJlY2VpdmVkX2Rh
dGEoR0lPQ2hhbm5lbCAqY2hhbm5lbCwgR0lPQ29uZGl0aW9uIGNvbmQsCiAJR0lPU3RhdHVzIHN0
YXR1czsKIAlnc2l6ZSBieXRlc19yZWFkOwogCi0JaWYgKGNvbmQgJmFtcDsgR19JT19OVkFMKQor
CWlmIChjb25kICZhbXA7IEdfSU9fTlZBTCkgeworCQltdXgtJmd0O3JlYWRfd2F0Y2ggPSAwOwog
CQlyZXR1cm4gRkFMU0U7CisJfQogCiAJZGVidWcobXV4LCAicmVjZWl2ZWQgZGF0YSIpOwogCkBA
IC0yMjMsMTQgKzIyNSwyMCBAQCBzdGF0aWMgZ2Jvb2xlYW4gcmVjZWl2ZWRfZGF0YShHSU9DaGFu
bmVsICpjaGFubmVsLCBHSU9Db25kaXRpb24gY29uZCwKIAkJfQogCX0KIAotCWlmIChjb25kICZh
bXA7IChHX0lPX0hVUCB8IEdfSU9fRVJSKSkKKwlpZiAoY29uZCAmYW1wOyAoR19JT19IVVAgfCBH
X0lPX0VSUikpIHsKKwkJbXV4LSZndDtyZWFkX3dhdGNoID0gMDsKIAkJcmV0dXJuIEZBTFNFOwor
CX0KIAotCWlmIChzdGF0dXMgIT0gR19JT19TVEFUVVNfTk9STUFMICZhbXA7JmFtcDsgc3RhdHVz
ICE9IEdfSU9fU1RBVFVTX0FHQUlOKQorCWlmIChzdGF0dXMgIT0gR19JT19TVEFUVVNfTk9STUFM
ICZhbXA7JmFtcDsgc3RhdHVzICE9IEdfSU9fU1RBVFVTX0FHQUlOKSB7CisJCW11eC0mZ3Q7cmVh
ZF93YXRjaCA9IDA7CiAJCXJldHVybiBGQUxTRTsKKwl9CiAKLQlpZiAobXV4LSZndDtidWZfdXNl
ZCA9PSBzaXplb2YobXV4LSZndDtidWYpKQorCWlmIChtdXgtJmd0O2J1Zl91c2VkID09IHNpemVv
ZihtdXgtJmd0O2J1ZikpIHsKKwkJbXV4LSZndDtyZWFkX3dhdGNoID0gMDsKIAkJcmV0dXJuIEZB
TFNFOworCX0KIAogCXJldHVybiBUUlVFOwogfQotLSAKMi43LjQKPC9wcmU+CiAgPC9ib2R5Pgo8
L2h0bWw+Cg==

--===============3487906726676633963==--

