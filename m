Content-Type: multipart/mixed; boundary="===============1235529785409211099=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] simutil: Made UMTS/GSM authenticate more consitent
Date: Wed, 01 Nov 2017 10:32:17 -0700
Message-ID: <1509557537-15050-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1235529785409211099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Le parameter in the AUTHENTICATE command was not being
set for GSM authentication. This did work, but explicitly
setting it to 0 as UMTS does was more consitent.
---
 src/simutil.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/simutil.c b/src/simutil.c
index 2f49500..c25b3a8 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1628,9 +1628,10 @@ static int build_authenticate(unsigned char *buffer,=
 const unsigned char *rand,
 		buffer[pos++] =3D 0x10;
 		memcpy(buffer + pos, autn, 16);
 		pos +=3D 16;
-		buffer[pos++] =3D 0x00;
 	}
 =

+	buffer[pos++] =3D 0x00;
+
 	return pos;
 }
 =

-- =

2.7.4


--===============1235529785409211099==--

