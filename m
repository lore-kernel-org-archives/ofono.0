Content-Type: multipart/mixed; boundary="===============6137707776480028576=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/3] smsutil: Change the range of time zone
Date: Tue, 30 Nov 2010 18:44:48 +0800
Message-ID: <1291113890-24465-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6137707776480028576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index b06e9bf..644e3e0 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -51,6 +51,13 @@
 #define SMS_ADDR_FMT "%24[0-9A-F]"
 #define SMS_MSGID_FMT "%40[0-9A-F]"
 =

+/*
+ * Time zone accounts for daylight saving time, and the two extreme time
+ * zones on earth are UTC-12 and UTC+14.
+ */
+#define MAX_TIMEZONE 56
+#define MIN_TIMEZONE -48
+
 static GSList *sms_assembly_add_fragment_backup(struct sms_assembly *assem=
bly,
 					const struct sms *sms, time_t ts,
 					const struct sms_address *addr,
@@ -339,7 +346,7 @@ gboolean sms_encode_scts(const struct sms_scts *in, uns=
igned char *pdu,
 	if (in->second > 59)
 		return FALSE;
 =

-	if ((in->timezone > 12*4-1) || (in->timezone < -(12*4-1)))
+	if ((in->timezone > MAX_TIMEZONE) || (in->timezone < MIN_TIMEZONE))
 		return FALSE;
 =

 	pdu =3D pdu + *offset;
@@ -426,7 +433,7 @@ gboolean sms_decode_scts(const unsigned char *pdu, int =
len,
 	if (oct & 0x08)
 		out->timezone =3D out->timezone * -1;
 =

-	if ((out->timezone > 12*4-1) || (out->timezone < -(12*4-1)))
+	if ((out->timezone > MAX_TIMEZONE) || (out->timezone < MIN_TIMEZONE))
 		return FALSE;
 =

 	return TRUE;
-- =

1.7.2.3


--===============6137707776480028576==--

