Content-Type: multipart/mixed; boundary="===============0089155304532033200=="
MIME-Version: 1.0
From: iiro.kaihlaniemi@nokia.com
Subject: [PATCH 5/5] isimodem: Add functionality to UICC
Date: Wed, 03 Aug 2011 10:44:15 +0000
Message-ID: <6B9DA0A3415B234191A1ADFA6275C51CB24180@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0089155304532033200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/isimodem/uicc.h b/drivers/isimodem/uicc.h
index 4b613eb..d3831c5 100644
--- a/drivers/isimodem/uicc.h
+++ b/drivers/isimodem/uicc.h
@@ -245,9 +245,14 @@ enum uicc_card_type {
 };
 =

 enum uicc_details {
-	UICC_NO_DETAILS =3D			0x00,
-	UICC_INVALID_PARAMETERS =3D		0x01,
-	UICC_FILE_NOT_FOUND =3D			0x02,
+	UICC_NO_DETAILS =3D				0x00,
+	UICC_INVALID_PARAMETERS =3D			0x01,
+	UICC_FILE_NOT_FOUND =3D				0x02,
+	UICC_SECURITY_CONDITIONS_NOT_SATISFIED =3D	0x03,
+	UICC_APPL_CONFLICT =3D				0x04,
+	UICC_CARD_ERROR =3D				0x05,
+	UICC_SERVICE_NOT_SUPPORTED =3D			0x06,
+	UICC_SESSION_EXPIRED =3D				0x07,
 };
 =

 enum uicc_simlock_status {

--===============0089155304532033200==--

