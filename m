Content-Type: multipart/mixed; boundary="===============4725293155160177498=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] Move debug print to more useful place
Date: Thu, 27 Sep 2018 23:47:35 +0200
Message-ID: <20180927214735.GE17346@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4725293155160177498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Move debug print to more useful place in setup_gobi().

index ff5d41af..a4b18488 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -233,10 +233,11 @@ static gboolean setup_gobi(struct modem_info *modem)
 		}
 	}
 =

+	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
+	=

 	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
 		return FALSE;
 =

-	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
 =

 	ofono_modem_set_string(modem->modem, "Device", qmi);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============4725293155160177498==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsdXRUL2NBQ2drUU1PZndhcFhiK3ZKTHF3Q2dyYXVyZEJEVTdDbFdMU0F0eWI3aTkwczEK
U2M0QW4wWEI3anZ5Z25LRVdFTVBwYlJnSWVrR0JSODYKPWppSmoKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============4725293155160177498==--

