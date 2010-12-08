Content-Type: multipart/mixed; boundary="===============7278627218168140741=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] smsutil: do not hardcode TP-ValidityPeriod
Date: Wed, 08 Dec 2010 23:57:01 +0200
Message-ID: <1291845421-1898-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7278627218168140741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/smsutil.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index f4eee24..59faaf7 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3162,11 +3162,10 @@ GSList *sms_datagram_prepare(const char *to,
 	memset(&template, 0, sizeof(struct sms));
 	template.type =3D SMS_TYPE_SUBMIT;
 	template.submit.rd =3D FALSE;
-	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_RELATIVE;
+	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_ABSENT;
 	template.submit.rp =3D FALSE;
 	template.submit.srr =3D use_delivery_reports;
 	template.submit.mr =3D 0;
-	template.submit.vp.relative =3D 0xA7; /* 24 Hours */
 	template.submit.dcs =3D 0x04; /* Class Unspecified, 8 Bit */
 	template.submit.udhi =3D TRUE;
 	sms_address_from_string(&template.submit.daddr, to);
@@ -3288,11 +3287,10 @@ GSList *sms_text_prepare(const char *to, const char=
 *utf8, guint16 ref,
 	memset(&template, 0, sizeof(struct sms));
 	template.type =3D SMS_TYPE_SUBMIT;
 	template.submit.rd =3D FALSE;
-	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_RELATIVE;
+	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_ABSENT;
 	template.submit.rp =3D FALSE;
 	template.submit.srr =3D use_delivery_reports;
 	template.submit.mr =3D 0;
-	template.submit.vp.relative =3D 0xA7; /* 24 Hours */
 	sms_address_from_string(&template.submit.daddr, to);
 =

 	/* UDHI, UDL, UD and DCS actually depend on what we have in the text */
-- =

1.7.1


--===============7278627218168140741==--

