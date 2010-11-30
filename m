Content-Type: multipart/mixed; boundary="===============8881814809456992214=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/3] Make timezone an optional field
Date: Tue, 30 Nov 2010 18:44:49 +0800
Message-ID: <1291113890-24465-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1291113890-24465-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8881814809456992214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   11 ++++++++++-
 src/smsutil.h |    1 +
 src/stkutil.c |   13 ++-----------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 644e3e0..20af30a 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -346,7 +346,8 @@ gboolean sms_encode_scts(const struct sms_scts *in, uns=
igned char *pdu,
 	if (in->second > 59)
 		return FALSE;
 =

-	if ((in->timezone > MAX_TIMEZONE) || (in->timezone < MIN_TIMEZONE))
+	if ((in->timezone > MAX_TIMEZONE || in->timezone < MIN_TIMEZONE) &&
+			in->has_timezone =3D=3D TRUE)
 		return FALSE;
 =

 	pdu =3D pdu + *offset;
@@ -358,6 +359,11 @@ gboolean sms_encode_scts(const struct sms_scts *in, un=
signed char *pdu,
 	pdu[4] =3D ((in->minute / 10) & 0x0f) | (((in->minute % 10) & 0x0f) << 4);
 	pdu[5] =3D ((in->second / 10) & 0x0f) | (((in->second % 10) & 0x0f) << 4);
 =

+	if (in->has_timezone =3D=3D FALSE) {
+		pdu[6] =3D 0xff;
+		goto out;
+	}
+
 	timezone =3D abs(in->timezone);
 =

 	pdu[6] =3D ((timezone / 10) & 0x07) | (((timezone % 10) & 0x0f) << 4);
@@ -365,6 +371,7 @@ gboolean sms_encode_scts(const struct sms_scts *in, uns=
igned char *pdu,
 	if (in->timezone < 0)
 		pdu[6] |=3D 0x8;
 =

+out:
 	*offset +=3D 7;
 =

 	return TRUE;
@@ -436,6 +443,8 @@ gboolean sms_decode_scts(const unsigned char *pdu, int =
len,
 	if ((out->timezone > MAX_TIMEZONE) || (out->timezone < MIN_TIMEZONE))
 		return FALSE;
 =

+	out->has_timezone =3D TRUE;
+
 	return TRUE;
 }
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index 4b05313..4b6159f 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -223,6 +223,7 @@ struct sms_scts {
 	guint8 hour;
 	guint8 minute;
 	guint8 second;
+	gboolean has_timezone;
 	gint8 timezone;
 };
 =

diff --git a/src/stkutil.c b/src/stkutil.c
index a211462..01a0021 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4548,7 +4548,6 @@ static gboolean build_dataobj_datetime_timezone(struc=
t stk_tlv_builder *tlv,
 						const void *data, gboolean cr)
 {
 	const struct sms_scts *scts =3D data;
-	struct sms_scts timestamp;
 	unsigned char value[7];
 	int offset =3D 0;
 	unsigned char tag =3D STK_DATA_OBJECT_TYPE_DATETIME_TIMEZONE;
@@ -4556,16 +4555,8 @@ static gboolean build_dataobj_datetime_timezone(stru=
ct stk_tlv_builder *tlv,
 	if (scts->month =3D=3D 0 && scts->day =3D=3D 0)
 		return TRUE;
 =

-	/* Time zone information is optional */
-	if (scts->timezone =3D=3D (gint8) 0xff) {
-		memcpy(&timestamp, scts, sizeof(timestamp));
-		timestamp.timezone =3D 0;
-		if (sms_encode_scts(&timestamp, value, &offset) !=3D TRUE)
-			return FALSE;
-		value[6] =3D 0xff;
-	} else
-		if (sms_encode_scts(scts, value, &offset) !=3D TRUE)
-			return FALSE;
+	if (sms_encode_scts(scts, value, &offset) !=3D TRUE)
+		return FALSE;
 =

 	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
 		stk_tlv_builder_append_bytes(tlv, value, 7) &&
-- =

1.7.2.3


--===============8881814809456992214==--

