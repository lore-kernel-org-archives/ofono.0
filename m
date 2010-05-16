Content-Type: multipart/mixed; boundary="===============6250777662088862968=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 26/27] smsutil: Expose SMS timestamp encoding utility.
Date: Sun, 16 May 2010 16:08:17 +0200
Message-ID: <1274018897-7096-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6250777662088862968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function can be re-used in stkutil.c, similarly to sms_decode_scts.
---
 src/smsutil.c |   14 +++++++-------
 src/smsutil.h |    3 +++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 17e0e0e..6f8e9c5 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -325,7 +325,7 @@ static inline gboolean set_octet(unsigned char *pdu, in=
t *offset,
 	return TRUE;
 }
 =

-static gboolean encode_scts(const struct sms_scts *in, unsigned char *pdu,
+gboolean sms_encode_scts(const struct sms_scts *in, unsigned char *pdu,
 				int *offset)
 {
 	guint timezone;
@@ -467,7 +467,7 @@ static gboolean encode_validity_period(const struct sms=
_validity_period *vp,
 		set_octet(pdu, offset, vp->relative);
 		return TRUE;
 	case SMS_VALIDITY_PERIOD_FORMAT_ABSOLUTE:
-		return encode_scts(&vp->absolute, pdu, offset);
+		return sms_encode_scts(&vp->absolute, pdu, offset);
 	case SMS_VALIDITY_PERIOD_FORMAT_ENHANCED:
 		/* TODO: Write out proper enhanced VP structure */
 		memcpy(pdu + *offset, vp->enhanced, 7);
@@ -677,7 +677,7 @@ static gboolean encode_deliver(const struct sms_deliver=
 *in, unsigned char *pdu,
 	set_octet(pdu, offset, in->pid);
 	set_octet(pdu, offset, in->dcs);
 =

-	if (encode_scts(&in->scts, pdu, offset) =3D=3D FALSE)
+	if (sms_encode_scts(&in->scts, pdu, offset) =3D=3D FALSE)
 		return FALSE;
 =

 	set_octet(pdu, offset, in->udl);
@@ -748,7 +748,7 @@ static gboolean encode_submit_ack_report(const struct s=
ms_submit_ack_report *in,
 =

 	set_octet(pdu, offset, in->pi);
 =

-	if (!encode_scts(&in->scts, pdu, offset))
+	if (!sms_encode_scts(&in->scts, pdu, offset))
 		return FALSE;
 =

 	if (in->pi & 0x1)
@@ -784,7 +784,7 @@ static gboolean encode_submit_err_report(const struct s=
ms_submit_err_report *in,
 =

 	set_octet(pdu, offset, in->pi);
 =

-	if (!encode_scts(&in->scts, pdu, offset))
+	if (!sms_encode_scts(&in->scts, pdu, offset))
 		return FALSE;
 =

 	if (in->pi & 0x1)
@@ -923,10 +923,10 @@ static gboolean encode_status_report(const struct sms=
_status_report *in,
 	if (!sms_encode_address_field(&in->raddr, FALSE, pdu, offset))
 		return FALSE;
 =

-	if (!encode_scts(&in->scts, pdu, offset))
+	if (!sms_encode_scts(&in->scts, pdu, offset))
 		return FALSE;
 =

-	if (!encode_scts(&in->dt, pdu, offset))
+	if (!sms_encode_scts(&in->dt, pdu, offset))
 		return FALSE;
 =

 	octet =3D in->st;
diff --git a/src/smsutil.h b/src/smsutil.h
index 469a49e..a060c1b 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -427,6 +427,9 @@ guint8 sms_decode_semi_octet(guint8 in);
 gboolean sms_decode_scts(const unsigned char *pdu, int len,
 				int *offset, struct sms_scts *out);
 =

+gboolean sms_encode_scts(const struct sms_scts *in, unsigned char *pdu,
+				int *offset);
+
 int sms_udl_in_bytes(guint8 ud_len, guint8 dcs);
 =

 time_t sms_scts_to_time(const struct sms_scts *scts, struct tm *remote);
-- =

1.7.1.86.g0e460.dirty


--===============6250777662088862968==--

