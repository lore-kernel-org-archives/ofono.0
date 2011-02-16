Content-Type: multipart/mixed; boundary="===============7434399456055052581=="
MIME-Version: 1.0
From: Paavo Leinonen <paavo.leinonen@tieto.com>
Subject: [PATCH] test: fix parameter type error in
 'test-advice-of-charge'-script
Date: Wed, 16 Feb 2011 10:58:53 +0200
Message-ID: <1297846733-9686-1-git-send-email-paavo.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7434399456055052581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-advice-of-charge |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/test-advice-of-charge b/test/test-advice-of-charge
index d71b7c6..9f3f655 100755
--- a/test/test-advice-of-charge
+++ b/test/test-advice-of-charge
@@ -73,7 +73,7 @@ if __name__ =3D=3D "__main__":
 	else:
 		try:
 			if property =3D=3D 'AccumulatedCallMeterMaximum':
-				newvalue =3D int(newvalue)
+				newvalue =3D dbus.UInt32(newvalue)
 			elif property =3D=3D 'PricePerUnit':
 				newvalue =3D float(newvalue)
 			cm.SetProperty(property, newvalue, pin)
-- =

1.7.1


--===============7434399456055052581==--

