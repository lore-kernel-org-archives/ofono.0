Content-Type: multipart/mixed; boundary="===============4372510499411882589=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] smsutil: Prevent out of bounds reads in cbs_decode_text
Date: Sun, 01 Jan 2017 20:48:02 +0300
Message-ID: <1483292882-18897-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4372510499411882589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Valgrind was complaining about it like this:

=3D=3D18099=3D=3D Conditional jump or move depends on uninitialised value(s)
=3D=3D18099=3D=3D    at 0x4C32281: strspn
=3D=3D18099=3D=3D    by 0x41286B: cbs_decode_text (smsutil.c:4140)
=3D=3D18099=3D=3D    by 0x40675C: test_cbs_encode_decode (test-sms.c:1417)
---
 src/smsutil.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 2212994..24dcfaa 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -4135,12 +4135,13 @@ char *cbs_decode_text(GSList *cbs_list, char *iso63=
9_lang)
 			 */
 			for (; i < written; i++, bufsize++) {
 				if (unpacked[i] =3D=3D '\r') {
-					int t;
+					int j;
 =

-					t =3D strspn((const char *) unpacked + i,
-							"\r");
+					for (j =3D i + 1; j < written; j++)
+						if (unpacked[j] !=3D '\r')
+							break;
 =

-					if (t + i =3D=3D written)
+					if (j =3D=3D written)
 						break;
 				}
 =

-- =

1.9.1


--===============4372510499411882589==--

