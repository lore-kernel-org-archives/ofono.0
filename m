Content-Type: multipart/mixed; boundary="===============5044585150763935781=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 08/15] Make function decode_scts public
Date: Fri, 02 Apr 2010 14:20:33 +0800
Message-ID: <1270189240-11650-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-7-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5044585150763935781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   12 ++++++------
 src/smsutil.h |    3 +++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 64cd6fb..17e0e0e 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -377,7 +377,7 @@ guint8 sms_decode_semi_octet(guint8 in)
 	return (in & 0x0f) * 10 + (in >> 4);
 }
 =

-static gboolean decode_scts(const unsigned char *pdu, int len,
+gboolean sms_decode_scts(const unsigned char *pdu, int len,
 				int *offset, struct sms_scts *out)
 {
 	unsigned char oct =3D 0;
@@ -433,7 +433,7 @@ static gboolean decode_validity_period(const unsigned c=
har *pdu, int len,
 =

 		return TRUE;
 	case SMS_VALIDITY_PERIOD_FORMAT_ABSOLUTE:
-		if (!decode_scts(pdu, len, offset, &vp->absolute))
+		if (!sms_decode_scts(pdu, len, offset, &vp->absolute))
 			return FALSE;
 =

 		return TRUE;
@@ -718,7 +718,7 @@ static gboolean decode_deliver(const unsigned char *pdu=
, int len,
 	if (!next_octet(pdu, len, &offset, &out->deliver.dcs))
 		return FALSE;
 =

-	if (!decode_scts(pdu, len, &offset, &out->deliver.scts))
+	if (!sms_decode_scts(pdu, len, &offset, &out->deliver.scts))
 		return FALSE;
 =

 	if (!next_octet(pdu, len, &offset, &out->deliver.udl))
@@ -849,7 +849,7 @@ static gboolean decode_submit_report(const unsigned cha=
r *pdu, int len,
 =

 	pi =3D octet & 0x07;
 =

-	if (!decode_scts(pdu, len, &offset, scts))
+	if (!sms_decode_scts(pdu, len, &offset, scts))
 		return FALSE;
 =

 	if (pi & 0x01) {
@@ -976,10 +976,10 @@ static gboolean decode_status_report(const unsigned c=
har *pdu, int len,
 					&out->status_report.raddr))
 		return FALSE;
 =

-	if (!decode_scts(pdu, len, &offset, &out->status_report.scts))
+	if (!sms_decode_scts(pdu, len, &offset, &out->status_report.scts))
 		return FALSE;
 =

-	if (!decode_scts(pdu, len, &offset, &out->status_report.dt))
+	if (!sms_decode_scts(pdu, len, &offset, &out->status_report.dt))
 		return FALSE;
 =

 	if (!next_octet(pdu, len, &offset, &octet))
diff --git a/src/smsutil.h b/src/smsutil.h
index fd80c8f..469a49e 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -424,6 +424,9 @@ gboolean sms_encode_address_field(const struct sms_addr=
ess *in, gboolean sc,
 =

 guint8 sms_decode_semi_octet(guint8 in);
 =

+gboolean sms_decode_scts(const unsigned char *pdu, int len,
+				int *offset, struct sms_scts *out);
+
 int sms_udl_in_bytes(guint8 ud_len, guint8 dcs);
 =

 time_t sms_scts_to_time(const struct sms_scts *scts, struct tm *remote);
-- =

1.6.3.3


--===============5044585150763935781==--

