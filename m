Content-Type: multipart/mixed; boundary="===============2572792369050237223=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH][v2] udevng/gobi: rework mandatory and optional interfaces
Date: Tue, 16 May 2017 18:12:37 +0200
Message-ID: <20170516161237.17860-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2572792369050237223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mandatory interfaces are QMI and net.
Optional interfaces are GPS, Modem, Diag.
---

Hi Denis,

I'm not sure how you want this patch ;). I can also split it in two parts
or you just drop the part you don't like.

Best,
lynxis


 plugins/udevng.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index aa28bcb8..072c727d 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -232,16 +232,38 @@ static gboolean setup_gobi(struct modem_info *modem)
 		}
 	}
 =

-	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
+	if (!qmi) {
+		DBG("mandatory qmi interface missing");
 		return FALSE;
+	}
+
+	if (!net) {
+		DBG("mandatory net interface missing");
+		return FALSE;
+	}
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
+	if (gps)
+		ofono_modem_set_string(modem->modem, "GPS", gps);
+	else
+		DBG("optional gps interface missing");
+
 	return TRUE;
 }
 =

-- =

2.13.0


--===============2572792369050237223==--

