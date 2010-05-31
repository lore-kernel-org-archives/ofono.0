Content-Type: multipart/mixed; boundary="===============1179089276184384008=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/11] Add a buffer size parameter to convert_utf8_to_gsm
Date: Mon, 31 May 2010 14:47:21 +0200
Message-ID: <1275310044-27469-8-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275310044-27469-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1179089276184384008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is needed when encoding a string into gsm that needs to fit a
in a given number of bytes.  Just taking the first N bytes of the
resulting string may leave you with byte 1 of a two-byte character at
the end of the buffer.  As far as I can tell there's no easier way to
avoid that.
---
 src/util.c       |    6 +++++-
 src/util.h       |    1 +
 unit/test-util.c |    3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/util.c b/src/util.c
index e5ce7b3..7c27301 100644
--- a/src/util.c
+++ b/src/util.c
@@ -645,6 +645,7 @@ char *convert_gsm_to_utf8(const unsigned char *text, lo=
ng len,
 unsigned char *convert_utf8_to_gsm_with_lang(const char *text, long len,
 					long *items_read, long *items_written,
 					unsigned char terminator,
+					long max_size,
 					enum gsm_dialect locking_lang,
 					enum gsm_dialect single_lang)
 {
@@ -688,6 +689,9 @@ unsigned char *convert_utf8_to_gsm_with_lang(const char=
 *text, long len,
 		else
 			res_len +=3D 1;
 =

+		if (max_size !=3D -1 && res_len > max_size)
+			break;
+
 		in =3D g_utf8_next_char(in);
 		nchars +=3D 1;
 	}
@@ -739,7 +743,7 @@ unsigned char *convert_utf8_to_gsm(const char *text, lo=
ng len,
 {
 	return convert_utf8_to_gsm_with_lang(text, len, items_read,
 						items_written,
-						terminator,
+						terminator, -1,
 						GSM_DIALECT_DEFAULT,
 						GSM_DIALECT_DEFAULT);
 }
diff --git a/src/util.h b/src/util.h
index 2835b76..d1b6b18 100644
--- a/src/util.h
+++ b/src/util.h
@@ -40,6 +40,7 @@ unsigned char *convert_utf8_to_gsm(const char *text, long=
 len, long *items_read,
 =

 unsigned char *convert_utf8_to_gsm_with_lang(const char *text, long len, l=
ong *items_read,
 				long *items_written, unsigned char terminator,
+				long max_size,
 				enum gsm_dialect locking_shift_lang,
 				enum gsm_dialect single_shift_lang);
 =

diff --git a/unit/test-util.c b/unit/test-util.c
index de62848..30f4157 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -468,7 +468,8 @@ static void test_valid_turkish()
 =

 		g_assert(nwritten =3D=3D UTF8_LENGTH(verify[0]));
 =

-		back =3D convert_utf8_to_gsm_with_lang(res, -1, &nread, &nwritten, 0, 1,=
 1);
+		back =3D convert_utf8_to_gsm_with_lang(res, -1, &nread,
+							&nwritten, 0, -1, 1, 1);
 =

 		g_assert(back);
 =

-- =

1.7.1.86.g0e460.dirty


--===============1179089276184384008==--

