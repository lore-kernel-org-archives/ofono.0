Content-Type: multipart/mixed; boundary="===============2937630959505139697=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/2] simutil: Fix EF_PNN access
Date: Fri, 14 Mar 2014 17:23:43 +0100
Message-ID: <1394814224-30014-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2937630959505139697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

EF_PNN was not being read properly (see TS 24.008, section 10.5.3.5a,
for network names format), which affected the displayed PLMN name for
some MVNOs. Some modems already read the file and return the right
string: these do not show the problem.
---
 src/simutil.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 90d7f8d..a7745ae 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -767,12 +767,14 @@ static char *sim_network_name_parse(const unsigned ch=
ar *buffer, int length,
 					gboolean *add_ci)
 {
 	char *ret =3D NULL;
-	unsigned char *endp;
 	unsigned char dcs;
 	int i;
 	gboolean ci =3D FALSE;
+	unsigned char *unpacked_buf;
+	long num_char, written;
+	int spare_bits;
 =

-	if (length < 1)
+	if (length < 2)
 		return NULL;
 =

 	dcs =3D *buffer++;
@@ -787,11 +789,18 @@ static char *sim_network_name_parse(const unsigned ch=
ar *buffer, int length,
 =

 	switch (dcs & (7 << 4)) {
 	case 0x00:
-		endp =3D memchr(buffer, 0xff, length);
-		if (endp)
-			length =3D endp - buffer;
-		ret =3D convert_gsm_to_utf8(buffer, length,
-				NULL, NULL, 0xff);
+		spare_bits =3D dcs & 0x07;
+		num_char =3D (length * 8 - spare_bits) / 7;
+
+		unpacked_buf =3D unpack_7bit(buffer, length, 0, FALSE,
+						num_char, &written, 0);
+		if (unpacked_buf =3D=3D NULL)
+			break;
+
+		ret =3D convert_gsm_to_utf8(unpacked_buf, written, NULL, NULL, 0);
+
+		g_free(unpacked_buf);
+
 		break;
 	case 0x10:
 		if ((length % 2) =3D=3D 1) {
-- =

1.8.3.2


--===============2937630959505139697==--

