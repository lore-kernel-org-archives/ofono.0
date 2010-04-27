Content-Type: multipart/mixed; boundary="===============3932261530207352536=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 6/7] stkutil: Change some dataobj parser to use char * instead
 of char **
Date: Tue, 27 Apr 2010 17:47:11 +0800
Message-ID: <1272361632-21352-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1272361632-21352-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3932261530207352536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2e0c957..a0166d0 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -611,7 +611,7 @@ static gboolean parse_dataobj_location_info(struct comp=
rehension_tlv_iter *iter,
 static gboolean parse_dataobj_imei(struct comprehension_tlv_iter *iter,
 					void *user)
 {
-	char **imei =3D user;
+	char *imei =3D user;
 	const unsigned char *data;
 	unsigned int len;
 	static const char digit_lut[] =3D "0123456789*#abc\0";
@@ -626,8 +626,8 @@ static gboolean parse_dataobj_imei(struct comprehension=
_tlv_iter *iter,
 		return FALSE;
 =

 	/* Assume imei is at least 16 bytes long (15 for imei + null) */
-	(*imei)[0] =3D digit_lut[(data[0] & 0xf0) >> 4];
-	extract_bcd_number(data + 1, 7, *imei + 1);
+	imei[0] =3D digit_lut[(data[0] & 0xf0) >> 4];
+	extract_bcd_number(data + 1, 7, imei + 1);
 =

 	return TRUE;
 }
@@ -644,7 +644,7 @@ static gboolean parse_dataobj_help_request(struct compr=
ehension_tlv_iter *iter,
 static gboolean parse_dataobj_network_measurement_results(
 		struct comprehension_tlv_iter *iter, void *user)
 {
-	unsigned char **nmr =3D user;
+	unsigned char *nmr =3D user;
 	const unsigned char *data;
 	unsigned int len;
 =

@@ -655,7 +655,7 @@ static gboolean parse_dataobj_network_measurement_resul=
ts(
 	data =3D comprehension_tlv_iter_get_data(iter);
 =

 	/* Assume network measurement result is 16 bytes long */
-	memcpy(*nmr, data, len);
+	memcpy(nmr, data, len);
 =

 	return TRUE;
 }
@@ -1430,7 +1430,7 @@ static gboolean parse_dataobj_remote_entity_address(
 static gboolean parse_dataobj_esn(struct comprehension_tlv_iter *iter,
 					void *user)
 {
-	unsigned char **esn =3D user;
+	unsigned char *esn =3D user;
 	const unsigned char *data;
 	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
 =

@@ -1440,7 +1440,7 @@ static gboolean parse_dataobj_esn(struct comprehensio=
n_tlv_iter *iter,
 	data =3D comprehension_tlv_iter_get_data(iter);
 =

 	/* Assume esn is 4 bytes long */
-	memcpy(*esn, data, len);
+	memcpy(esn, data, len);
 =

 	return TRUE;
 }
@@ -1528,7 +1528,7 @@ static gboolean parse_dataobj_item_text_attribute_lis=
t(
 static gboolean parse_dataobj_imeisv(struct comprehension_tlv_iter *iter,
 					void *user)
 {
-	char **imeisv =3D user;
+	char *imeisv =3D user;
 	const unsigned char *data;
 	unsigned int len;
 	static const char digit_lut[] =3D "0123456789*#abc\0";
@@ -1546,10 +1546,10 @@ static gboolean parse_dataobj_imeisv(struct compreh=
ension_tlv_iter *iter,
 		return FALSE;
 =

 	/* Assume imeisv is at least 17 bytes long (16 for imeisv + null) */
-	(*imeisv)[0] =3D digit_lut[data[0] >> 4];
-	extract_bcd_number(data + 1, 7, *imeisv + 1);
-	(*imeisv)[15] =3D digit_lut[data[8] & 0x0f];
-	(*imeisv)[16] =3D '\0';
+	imeisv[0] =3D digit_lut[data[0] >> 4];
+	extract_bcd_number(data + 1, 7, imeisv + 1);
+	imeisv[15] =3D digit_lut[data[8] & 0x0f];
+	imeisv[16] =3D '\0';
 =

 	return TRUE;
 }
@@ -1656,7 +1656,7 @@ static gboolean parse_dataobj_frame_id(struct compreh=
ension_tlv_iter *iter,
 static gboolean parse_dataobj_meid(struct comprehension_tlv_iter *iter,
 					void *user)
 {
-	unsigned char **meid =3D user;
+	unsigned char *meid =3D user;
 	const unsigned char *data;
 =

 	if (comprehension_tlv_iter_get_length(iter) !=3D 8)
@@ -1665,7 +1665,7 @@ static gboolean parse_dataobj_meid(struct comprehensi=
on_tlv_iter *iter,
 	data =3D comprehension_tlv_iter_get_data(iter);
 =

 	/* Assume meid is 8 bytes long */
-	memcpy(*meid, data, 8);
+	memcpy(meid, data, 8);
 =

 	return TRUE;
 }
-- =

1.7.0.4


--===============3932261530207352536==--

