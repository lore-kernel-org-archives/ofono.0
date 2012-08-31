Content-Type: multipart/mixed; boundary="===============1213192271493673424=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 1/3] smsutil: Fix style issues
Date: Fri, 31 Aug 2012 17:03:56 +0200
Message-ID: <1346425438-12220-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1213192271493673424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index a541964..b4d129f 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -81,11 +81,11 @@ void extract_bcd_number(const unsigned char *buf, int l=
en, char *out)
 	for (i =3D 0; i < len; i++) {
 		oct =3D buf[i];
 =

-		out[i*2] =3D digit_lut[oct & 0x0f];
-		out[i*2+1] =3D digit_lut[(oct & 0xf0) >> 4];
+		out[i * 2] =3D digit_lut[oct & 0x0f];
+		out[i * 2 + 1] =3D digit_lut[(oct & 0xf0) >> 4];
 	}
 =

-	out[i*2] =3D '\0';
+	out[i * 2] =3D '\0';
 }
 =

 static inline int to_semi_oct(char in)
@@ -600,7 +600,7 @@ gboolean sms_encode_address_field(const struct sms_addr=
ess *in, gboolean sc,
 out:
 	pdu[0] =3D addr_len;
 	pdu[1] =3D (in->number_type << 4) | in->numbering_plan | 0x80;
-	memcpy(pdu+2, p, (sc ? addr_len - 1 : (addr_len + 1) / 2));
+	memcpy(pdu + 2, p, (sc ? addr_len - 1 : (addr_len + 1) / 2));
 =

 	*offset =3D *offset + 2 + (sc ? addr_len - 1 : (addr_len + 1) / 2);
 =

@@ -768,7 +768,7 @@ static gboolean decode_deliver(const unsigned char *pdu=
, int len,
 	if ((len - offset) < expected)
 		return FALSE;
 =

-	memcpy(out->deliver.ud, pdu+offset, expected);
+	memcpy(out->deliver.ud, pdu + offset, expected);
 =

 	return TRUE;
 }
@@ -929,11 +929,11 @@ static gboolean decode_submit_report(const unsigned c=
har *pdu, int len,
 		if (out->type =3D=3D SMS_TYPE_SUBMIT_REPORT_ERROR) {
 			out->submit_err_report.udl =3D udl;
 			memcpy(out->submit_err_report.ud,
-					pdu+offset, expected);
+					pdu + offset, expected);
 		} else {
 			out->submit_ack_report.udl =3D udl;
 			memcpy(out->submit_ack_report.ud,
-					pdu+offset, expected);
+					pdu + offset, expected);
 		}
 	}
 =

@@ -1063,7 +1063,7 @@ static gboolean decode_status_report(const unsigned c=
har *pdu, int len,
 		if ((len - offset) < expected)
 			return FALSE;
 =

-		memcpy(out->status_report.ud, pdu+offset, expected);
+		memcpy(out->status_report.ud, pdu + offset, expected);
 	}
 =

 	return TRUE;
@@ -1214,11 +1214,11 @@ static gboolean decode_deliver_report(const unsigne=
d char *pdu, int len,
 		if (out->type =3D=3D SMS_TYPE_DELIVER_REPORT_ERROR) {
 			out->deliver_err_report.udl =3D udl;
 			memcpy(out->deliver_err_report.ud,
-					pdu+offset, expected);
+					pdu + offset, expected);
 		} else {
 			out->deliver_ack_report.udl =3D udl;
 			memcpy(out->deliver_ack_report.ud,
-					pdu+offset, expected);
+					pdu + offset, expected);
 		}
 	}
 =

@@ -1371,7 +1371,7 @@ static gboolean decode_submit(const unsigned char *pd=
u, int len,
 	if (expected > (int) sizeof(out->submit.ud))
 		return FALSE;
 =

-	memcpy(out->submit.ud, pdu+offset, expected);
+	memcpy(out->submit.ud, pdu + offset, expected);
 =

 	return TRUE;
 }
@@ -1450,7 +1450,7 @@ static gboolean decode_command(const unsigned char *p=
du, int len,
 	if ((len - offset) < out->command.cdl)
 		return FALSE;
 =

-	memcpy(out->command.cd, pdu+offset, out->command.cdl);
+	memcpy(out->command.cd, pdu + offset, out->command.cdl);
 =

 	return TRUE;
 }
@@ -1866,7 +1866,7 @@ void sms_address_from_string(struct sms_address *addr=
, const char *str)
 	addr->numbering_plan =3D SMS_NUMBERING_PLAN_ISDN;
 	if (str[0] =3D=3D '+') {
 		addr->number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL;
-		strcpy(addr->address, str+1);
+		strcpy(addr->address, str + 1);
 	} else {
 		addr->number_type =3D SMS_NUMBER_TYPE_UNKNOWN;
 		strcpy(addr->address, str);
@@ -4139,7 +4139,7 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 					break;
 =

 				buf[bufsize] =3D ud[i];
-				buf[bufsize + 1] =3D ud[i+1];
+				buf[bufsize + 1] =3D ud[i + 1];
 =

 				bufsize +=3D 2;
 				i +=3D 2;
-- =

1.7.9.5


--===============1213192271493673424==--

