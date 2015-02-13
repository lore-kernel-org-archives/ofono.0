Content-Type: multipart/mixed; boundary="===============7473517696098628489=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH] sms: SMS-DELIVER TP-OA Alphanum decoding and encoding fix
Date: Fri, 13 Feb 2015 17:50:16 +0200
Message-ID: <87e97632c94a76a5c5391485a0a5e34637ed8a50.1423832864.git.tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7473517696098628489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

TP-OA max length comparisons were incorrect because TP-OA's 7-bit
coded octets transport eleven 8-bit chars which take 23 bytes in UTF-8.
Increase address array accordingly and don't compare byte length to
character limit, but to a proper limit.
---
 src/smsutil.c |   12 +++++++++---
 src/smsutil.h |    6 +++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index be60ee9..213e50e 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -524,7 +524,8 @@ static gboolean encode_validity_period(const struct sms=
_validity_period *vp,
 gboolean sms_encode_address_field(const struct sms_address *in, gboolean s=
c,
 					unsigned char *pdu, int *offset)
 {
-	size_t len =3D strlen(in->address);
+	const char *addr =3D (const char *)&in->address;
+	size_t len =3D strlen(addr);
 	unsigned char addr_len =3D 0;
 	unsigned char p[10];
 =

@@ -546,7 +547,8 @@ gboolean sms_encode_address_field(const struct sms_addr=
ess *in, gboolean sc,
 		unsigned char *gsm;
 		unsigned char *r;
 =

-		if (len > 11)
+		/* TP-OA's 10 octets transport 11 8-bit chars */
+		if (g_utf8_strlen(addr, strlen(addr)) > 11)
 			return FALSE;
 =

 		gsm =3D convert_utf8_to_gsm(in->address, len, NULL, &written, 0);
@@ -675,7 +677,11 @@ gboolean sms_decode_address_field(const unsigned char =
*pdu, int len,
 		if (utf8 =3D=3D NULL)
 			return FALSE;
 =

-		if (strlen(utf8) > 20) {
+		/*
+		 * TP-OA's 10 octets transport 11 8-bit chars,
+		 * 22 bytes+terminator in UTF-8.
+		 */
+		if (strlen(utf8) > 22) {
 			g_free(utf8);
 			return FALSE;
 		}
diff --git a/src/smsutil.h b/src/smsutil.h
index b1001f8..d252810 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -220,7 +220,11 @@ enum cbs_geo_scope {
 struct sms_address {
 	enum sms_number_type number_type;
 	enum sms_numbering_plan numbering_plan;
-	char address[21]; /* Max 20 in semi-octet, 11 in alnum */
+	/*
+	 * An alphanum TP-OA is 10 7-bit coded octets, which can carry
+	 * 11 8-bit characters. 22 bytes + terminator in UTF-8.
+	 */
+	char address[23];
 };
 =

 struct sms_scts {
-- =

1.7.9.5


--===============7473517696098628489==--

