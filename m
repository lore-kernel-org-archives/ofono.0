Content-Type: multipart/mixed; boundary="===============6130562029220501369=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 27/27] simutil: Add MMC MNC pair encoding utility.
Date: Sun, 16 May 2010 16:08:29 +0200
Message-ID: <1274018909-7128-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6130562029220501369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |   17 +++++++++++++++++
 src/simutil.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index a0e824a..78270ba 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -884,6 +884,23 @@ void sim_parse_mcc_mnc(const guint8 *bcd, char *mcc, c=
har *mnc)
 	*mnc++ =3D digit_lut[digit];
 }
 =

+void sim_encode_mcc_mnc(guint8 *out, const char *mcc, const char *mnc)
+{
+	char str[7] =3D "ffffff";
+
+	str[0] =3D mcc[0];
+	str[1] =3D mcc[1];
+	if (mcc[2])
+		str[2] =3D mcc[2];
+
+	str[4] =3D mnc[0];
+	str[5] =3D mnc[1];
+	if (mnc[2])
+		str[3] =3D mnc[2];
+
+	encode_bcd_number(str, out);
+}
+
 static gint spdi_operator_compare(gconstpointer a, gconstpointer b)
 {
 	const struct spdi_operator *opa =3D a;
diff --git a/src/simutil.h b/src/simutil.h
index 53e7743..2b3b604 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -232,6 +232,7 @@ const struct sim_eons_operator_info *sim_eons_lookup(st=
ruct sim_eons *eons,
 void sim_eons_free(struct sim_eons *eons);
 =

 void sim_parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc);
+void sim_encode_mcc_mnc(guint8 *out, const char *mcc, const char *mnc);
 struct sim_spdi *sim_spdi_new(const guint8 *tlv, int length);
 gboolean sim_spdi_lookup(struct sim_spdi *spdi,
 				const char *mcc, const char *mnc);
-- =

1.7.1.86.g0e460.dirty


--===============6130562029220501369==--

