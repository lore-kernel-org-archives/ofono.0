Content-Type: multipart/mixed; boundary="===============1524202403389732282=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] util: Remove extra tab
Date: Wed, 17 Nov 2010 07:32:43 -0800
Message-ID: <1290007963-9806-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1524202403389732282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/util.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/util.c b/src/util.c
index 94b2fca..511683a 100644
--- a/src/util.c
+++ b/src/util.c
@@ -956,7 +956,7 @@ unsigned char *unpack_7bit_own_buf(const unsigned char =
*in, long len,
 	 * character.
 	 */
 	if (ussd && (((out - buf) % 8) =3D=3D 0) && (*(out - 1) =3D=3D '\r'))
-			out =3D out - 1;
+		out =3D out - 1;
 =

 	if (terminator)
 		*out =3D terminator;
-- =

1.7.0.4


--===============1524202403389732282==--

