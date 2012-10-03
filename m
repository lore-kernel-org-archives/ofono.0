Content-Type: multipart/mixed; boundary="===============0414379928538672082=="
MIME-Version: 1.0
From: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH] smsutil: Remove compilation warning
Date: Wed, 03 Oct 2012 11:08:19 -0300
Message-ID: <1349273299-1210-1-git-send-email-hdante@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0414379928538672082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index e3b4b72..7399fbe 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -4108,7 +4108,7 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 			 */
 			for (; i < written; i++, bufsize++) {
 				if (unpacked[i] =3D=3D '\r') {
-					unsigned int t;
+					long t;
 =

 					t =3D strspn((const char *) unpacked + i,
 							"\r");
-- =

1.7.12.rc2.16.g034161a


--===============0414379928538672082==--

