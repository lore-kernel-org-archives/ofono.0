Content-Type: multipart/mixed; boundary="===============6627366400039116709=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 06/15] Refactor function decode_scts to use semi octet decoder
Date: Fri, 02 Apr 2010 14:20:31 +0800
Message-ID: <1270189240-11650-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6627366400039116709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   17 +++++++++++------
 src/smsutil.h |    2 ++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index baa7ebe..64cd6fb 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -372,6 +372,11 @@ static gboolean encode_scts(const struct sms_scts *in,=
 unsigned char *pdu,
 	return TRUE;
 }
 =

+guint8 sms_decode_semi_octet(guint8 in)
+{
+	return (in & 0x0f) * 10 + (in >> 4);
+}
+
 static gboolean decode_scts(const unsigned char *pdu, int len,
 				int *offset, struct sms_scts *out)
 {
@@ -381,22 +386,22 @@ static gboolean decode_scts(const unsigned char *pdu,=
 int len,
 		return FALSE;
 =

 	next_octet(pdu, len, offset, &oct);
-	out->year =3D (oct & 0x0f) * 10 + ((oct & 0xf0) >> 4);
+	out->year =3D sms_decode_semi_octet(oct);
 =

 	next_octet(pdu, len, offset, &oct);
-	out->month =3D (oct & 0x0f) * 10 + ((oct & 0xf0) >> 4);
+	out->month =3D sms_decode_semi_octet(oct);
 =

 	next_octet(pdu, len, offset, &oct);
-	out->day =3D (oct & 0x0f) * 10 + ((oct & 0xf0) >> 4);
+	out->day =3D sms_decode_semi_octet(oct);
 =

 	next_octet(pdu, len, offset, &oct);
-	out->hour =3D (oct & 0x0f) * 10 + ((oct & 0xf0) >> 4);
+	out->hour =3D sms_decode_semi_octet(oct);
 =

 	next_octet(pdu, len, offset, &oct);
-	out->minute =3D (oct & 0x0f) * 10 + ((oct & 0xf0) >> 4);
+	out->minute =3D sms_decode_semi_octet(oct);
 =

 	next_octet(pdu, len, offset, &oct);
-	out->second =3D (oct & 0x0f) * 10 + ((oct & 0xf0) >> 4);
+	out->second =3D sms_decode_semi_octet(oct);
 =

 	next_octet(pdu, len, offset, &oct);
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index c28a6da..fd80c8f 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -422,6 +422,8 @@ gboolean sms_decode_address_field(const unsigned char *=
pdu, int len,
 gboolean sms_encode_address_field(const struct sms_address *in, gboolean s=
c,
 					unsigned char *pdu, int *offset);
 =

+guint8 sms_decode_semi_octet(guint8 in);
+
 int sms_udl_in_bytes(guint8 ud_len, guint8 dcs);
 =

 time_t sms_scts_to_time(const struct sms_scts *scts, struct tm *remote);
-- =

1.6.3.3


--===============6627366400039116709==--

