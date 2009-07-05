Content-Type: multipart/mixed; boundary="===============5774833015728510396=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Parse SIM alpha fields (EF-SPN) according to TS 11.11.
Date: Sun, 05 Jul 2009 05:14:01 +0200
Message-ID: <1246763641-17247-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5774833015728510396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |  119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 8485e1e..a5d2164 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -199,6 +199,115 @@ static GDBusMethodTable sim_manager_methods[] =3D {
 =

 static GDBusSignalTable sim_manager_signals[] =3D { { } };
 =

+static char *sim_alpha_field_parse(const unsigned char *buffer, int length)
+{
+	long utf_len, char_len;
+	unsigned char str[2];
+	int i;
+	char *r, *ret;
+
+	if (length < 1)
+		return NULL;
+
+	if (buffer[0] < 0x80)
+		return convert_gsm_to_utf8(buffer, length, NULL, NULL, 0xff);
+	switch (buffer[0]) {
+	case 0x80:
+		if (length < 2)
+			return NULL;
+
+		return convert_ucs2_to_utf8(buffer + 1, length - 1,
+				NULL, NULL, 0xffff);
+
+	case 0x81:
+		if (length < 4 || buffer[1] =3D=3D 0 || buffer[1] > length - 3)
+			return NULL;
+
+		length =3D buffer[1];
+		utf_len =3D 0;
+		for (i =3D 0; i < length; i ++) {
+			if (buffer[3 + i] & 0x80) {
+				str[0] =3D (buffer[2] >> 1);
+				str[1] =3D (buffer[2] << 7) |
+					(buffer[3 + i] & 0x7f);
+				r =3D convert_ucs2_to_utf8(str, 2,
+						NULL, &char_len, 0xffff);
+			} else
+				r =3D convert_gsm_to_utf8(&buffer[3 + i], 1,
+						NULL, &char_len, 0xff);
+
+			if (!r)
+				break;
+			g_free(r);
+			utf_len +=3D char_len;
+		}
+
+		ret =3D g_malloc(utf_len + 1);
+
+		for (i =3D 0; i < length; i ++) {
+			if (buffer[3 + i] & 0x80) {
+				str[0] =3D (buffer[2] >> 1);
+				str[1] =3D (buffer[2] << 7) |
+					(buffer[3 + i] & 0x7f);
+				r =3D convert_ucs2_to_utf8(str, 2,
+						NULL, &char_len, 0xffff);
+			} else
+				r =3D convert_gsm_to_utf8(&buffer[3 + i], 1,
+						NULL, &char_len, 0xff);
+
+			memcpy(ret + utf_len, r, char_len);
+			g_free(r);
+			utf_len +=3D char_len;
+		}
+		ret[utf_len] =3D 0;
+
+		return ret;
+
+	case 0x82:
+		if (length < 5 || buffer[1] =3D=3D 0 || buffer[1] > length - 4)
+			return NULL;
+
+		length =3D buffer[1];
+		for (i =3D 0; i < length; i ++) {
+			if (buffer[4 + i] & 0x80) {
+				str[0] =3D buffer[2];
+				str[1] =3D buffer[3] + (buffer[4 + i] & 0x7f);
+				r =3D convert_ucs2_to_utf8(str, 2,
+						NULL, &char_len, 0xffff);
+			} else
+				r =3D convert_gsm_to_utf8(&buffer[4 + i], 1,
+						NULL, &char_len, 0xff);
+
+			if (!r)
+				break;
+			g_free(r);
+			utf_len +=3D char_len;
+		}
+
+		ret =3D g_malloc(utf_len + 1);
+
+		for (i =3D 0; i < length; i ++) {
+			if (buffer[4 + i] & 0x80) {
+				str[0] =3D buffer[2];
+				str[1] =3D buffer[3] + (buffer[4 + i] & 0x7f);
+				r =3D convert_ucs2_to_utf8(str, 2,
+						NULL, &char_len, 0xffff);
+			} else
+				r =3D convert_gsm_to_utf8(&buffer[4 + i], 1,
+						NULL, &char_len, 0xff);
+
+			memcpy(ret + utf_len, r, char_len);
+			g_free(r);
+			utf_len +=3D char_len;
+		}
+		ret[utf_len] =3D 0;
+
+		return ret;
+	}
+
+	return NULL;
+}
+
 enum sim_fileids {
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
@@ -237,9 +346,7 @@ static void sim_spn_read_cb(const struct ofono_error *e=
rror,
 	if (endp)
 		length =3D endp - sdata;
 =

-	/*
-	 * The specification has this to say about the encoding of SPN:
-	 * Coding:
+	/* TS 31.102 says:
 	 *
 	 * the string shall use:
 	 *
@@ -250,9 +357,11 @@ static void sim_spn_read_cb(const struct ofono_error *=
error,
 	 * - or one of the UCS2 code options defined in the annex of TS
 	 *   31.101 [11].
 	 *
-	 * Assume the first option.
+	 * 31.101 has no such annex though.  51.101 refers to Annex B of
+	 * itself which is not there either.  11.11 contains the same
+	 * paragraph as 51.101 and has an Annex B which we implement.
 	 */
-	sim->spn =3D convert_gsm_to_utf8(sdata, length, NULL, NULL, 0xff);
+	sim->spn =3D sim_alpha_field_parse(sdata, length);
 =

 	for (l =3D sim->update_spn_notify; l; l =3D l->next)
 		sim_spn_notify(modem, l->data);
-- =

1.6.0


--===============5774833015728510396==--

