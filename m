Content-Type: multipart/mixed; boundary="===============1850312305795221285=="
MIME-Version: 1.0
From: Jimmy Gysens <jimmy.gysens_ext@softathome.com>
Subject: [PATCH] atmodem: set PDP/EPS minimum context ID to 1.
Date: Thu, 25 Jun 2020 11:29:24 +0200
Message-ID: <20200625092924.4677-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1850312305795221285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are manufacturers, like Huawei, returning profile 0 as the minimum
PDP/EPS context ID. Profile 0, however, is the default profile used to
register to the LTE network. It contains manufacturer specific settings and
should not be created by +CGDCONT.

Reference: ETSI TS 127 007: AT command set for User Equipment (UE), section
10.1.0.
---
 drivers/atmodem/gprs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 58d4eed3..bcf1eaaf 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -787,6 +787,13 @@ static void at_cgdcont_test_cb(gboolean ok, GAtResult =
*result,
 	if (found =3D=3D FALSE)
 		goto error;
 =

+	/*
+	 * ETSI TS 127 007: profile 0 is manufacturer specific.
+	 * Start from PDP/EPS context ID 1.
+	 */
+	if (min <=3D 0)
+		min =3D 1;
+
 	ofono_gprs_set_cid_range(gprs, min, max);
 =

 	g_at_chat_send(gd->chat, "AT+CGREG=3D?", cgreg_prefix,
-- =

2.17.1

--===============1850312305795221285==--

