Content-Type: multipart/mixed; boundary="===============6911478149858191908=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 4/7] udevng/gobi: make modem and diag interface optional
Date: Mon, 01 May 2017 22:52:53 +0200
Message-ID: <20170501205256.4205-4-lynxis@fe80.eu>
In-Reply-To: <20170501205256.4205-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6911478149858191908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Neither the modem nor the diag interface is used by the gobi driver.
---
 plugins/udevng.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4d928d02..bd954f4b 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -224,11 +224,9 @@ static gboolean setup_gobi(struct modem_info *modem)
 		}
 	}
 =

-	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL) {
+	if (qmi =3D=3D NULL || net =3D=3D NULL) {
 		if (!qmi)
 			DBG("mandatory qmi interface missing");
-		if (!mdm)
-			DBG("mandatory mdm interface missing");
 		if (!net)
 			DBG("mandatory net interface missing");
 		return FALSE;
@@ -236,11 +234,21 @@ static gboolean setup_gobi(struct modem_info *modem)
 =

 	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
 =

+	/* mandatory interface */
 	ofono_modem_set_string(modem->modem, "Device", qmi);
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-	ofono_modem_set_string(modem->modem, "Diag", diag);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 =

+	/* optional */
+	if (diag)
+		ofono_modem_set_string(modem->modem, "Diag", diag);
+	else
+		DBG("optional diag interface missing");
+
+	if (mdm)
+		ofono_modem_set_string(modem->modem, "Modem", mdm);
+	else
+		DBG("optional mdm interface missing");
+
 	return TRUE;
 }
 =

-- =

2.12.2


--===============6911478149858191908==--

