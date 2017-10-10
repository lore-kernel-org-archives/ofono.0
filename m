Content-Type: multipart/mixed; boundary="===============0582566354531894333=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv2 02/11] simutil: Added authenticate builder/parser API
Date: Tue, 10 Oct 2017 14:36:11 -0700
Message-ID: <1507671380-7625-2-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507671380-7625-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0582566354531894333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Used to compose/parse non-TLV formatted authenticate commands
for GSM and UMTS authentication.
---
 src/simutil.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simutil.h |  14 +++++++
 2 files changed, 144 insertions(+)

diff --git a/src/simutil.c b/src/simutil.c
index f43c2c2..69783bd 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1609,3 +1609,133 @@ error:
 =

 	return NULL;
 }
+
+static int build_authenticate(unsigned char *buffer, const unsigned char *=
rand,
+		const unsigned char *autn)
+{
+	int pos =3D 0;
+
+	buffer[pos++] =3D 0x00;
+	buffer[pos++] =3D 0x88;
+	buffer[pos++] =3D 0x00;
+	buffer[pos++] =3D autn ? 0x81 : 0x80;
+	buffer[pos++] =3D autn ? 0x22 : 0x11;
+	buffer[pos++] =3D 0x10;
+	memcpy(buffer + pos, rand, 16);
+	pos +=3D 16;
+
+	if (autn) {
+		buffer[pos++] =3D 0x10;
+		memcpy(buffer + pos, autn, 16);
+		pos +=3D 16;
+		buffer[pos++] =3D 0x00;
+	}
+
+	return pos;
+}
+
+int sim_build_umts_authenticate(unsigned char *buffer, int len,
+		const unsigned char *rand, const unsigned char *autn)
+{
+	if (len < 40 || !rand || !autn)
+		return FALSE;
+
+	return build_authenticate(buffer, rand, autn);
+}
+
+int sim_build_gsm_authenticate(unsigned char *buffer, int len,
+		const unsigned char *rand)
+{
+	if (len < 22 || !rand)
+		return FALSE;
+
+	return build_authenticate(buffer, rand, NULL);
+}
+
+#include <stdio.h>
+
+gboolean sim_parse_umts_authenticate(const unsigned char *buffer,
+		int len, const unsigned char **res, const unsigned char **ck,
+		const unsigned char **ik, const unsigned char **auts,
+		const unsigned char **kc)
+{
+	if (len < 18 || !buffer)
+		return FALSE;
+
+	switch (buffer[0]) {
+	case 0xdb:
+		/* 'DB' + '08' + RES(16) + '10' + CK(32) + '10' + IK(32) =3D 43 */
+		if (len < 43)
+			goto umts_end;
+
+		/* success */
+		if (buffer[1] !=3D 0x08)
+			goto umts_end;
+
+		*res =3D buffer + 2;
+
+		if (buffer[10] !=3D 0x10)
+			goto umts_end;
+
+		*ck =3D buffer + 11;
+
+		if (buffer[27] !=3D 0x10)
+			goto umts_end;
+
+		*ik =3D buffer + 28;
+
+		if (len >=3D 53 && kc) {
+			if (buffer[44] !=3D 0x08)
+				goto umts_end;
+
+			*kc =3D buffer + 45;
+		} else {
+			*kc =3D NULL;
+		}
+
+		*auts =3D NULL;
+
+		break;
+	case 0xdc:
+		/* 'DB' + '10' + AUTS(16) =3D 18 */
+		if (len < 18)
+			goto umts_end;
+
+		/* sync error */
+		if (buffer[1] !=3D 0x10)
+			goto umts_end;
+
+		*auts =3D buffer + 2;
+
+		break;
+	default:
+		goto umts_end;
+	}
+
+	return TRUE;
+
+umts_end:
+	return FALSE;
+}
+
+gboolean sim_parse_gsm_authenticate(const unsigned char *buffer, int len,
+		const unsigned char **sres, const unsigned char **kc)
+{
+	if (len < 14 || !buffer)
+		goto gsm_end;
+
+	if (buffer[0] !=3D 0x04)
+		goto gsm_end;
+
+	*sres =3D buffer + 1;
+
+	if (buffer[5] !=3D 0x08)
+		goto gsm_end;
+
+	*kc =3D buffer + 6;
+
+	return TRUE;
+
+gsm_end:
+	return FALSE;
+}
diff --git a/src/simutil.h b/src/simutil.h
index 9984b2c..ece5145 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -507,3 +507,17 @@ gboolean sim_cphs_is_active(unsigned char *service_cph=
s,
 				enum sim_cphs_service index);
 =

 GSList *sim_parse_app_template_entries(const unsigned char *buffer, int le=
n);
+
+int sim_build_umts_authenticate(unsigned char *buffer, int len,
+		const unsigned char *rand, const unsigned char *autn);
+
+int sim_build_gsm_authenticate(unsigned char *buffer, int len,
+		const unsigned char *rand);
+
+gboolean sim_parse_umts_authenticate(const unsigned char *buffer,
+		int len, const unsigned char **res, const unsigned char **ck,
+		const unsigned char **ik, const unsigned char **auts,
+		const unsigned char **kc);
+
+gboolean sim_parse_gsm_authenticate(const unsigned char *buffer, int len,
+		const unsigned char **sres, const unsigned char **kc);
-- =

2.7.4


--===============0582566354531894333==--

