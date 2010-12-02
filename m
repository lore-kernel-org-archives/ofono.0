Content-Type: multipart/mixed; boundary="===============5527677359855951204=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] smsutil: Fix issue in mwi dcs decoding
Date: Thu, 02 Dec 2010 01:43:27 -0800
Message-ID: <1291283007-17973-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5527677359855951204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index b06e9bf..ccd30f6 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -219,7 +219,12 @@ gboolean sms_mwi_dcs_decode(guint8 dcs, enum sms_mwi_t=
ype *type,
 	else
 		dis =3D FALSE;
 =

-	if (upper =3D=3D 3)
+	/*
+	 * As per 3GPP TS 23.038 specification, if bits 7..4 set to 1110,
+	 * text included in the user data is coded in the uncompresssed
+	 * UCS2 character set.
+	 */
+	if (upper =3D=3D 2)
 		ch =3D SMS_CHARSET_UCS2;
 	else
 		ch =3D SMS_CHARSET_7BIT;
-- =

1.7.0.4


--===============5527677359855951204==--

