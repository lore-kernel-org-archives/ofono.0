Content-Type: multipart/mixed; boundary="===============0404276621974271690=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 2/2] dundee: Fix typo in dundee-disconnect test
Date: Fri, 22 Feb 2013 14:01:12 -0300
Message-ID: <1361552472-23096-2-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1361552472-23096-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0404276621974271690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/dundee-disconnect |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/dundee-disconnect b/test/dundee-disconnect
index 5b3113e..a285dc8 100755
--- a/test/dundee-disconnect
+++ b/test/dundee-disconnect
@@ -13,7 +13,7 @@ else:
 	devices =3D manager.GetDevices()
 	path =3D devices[0][0]
 =

-print "Disonnect device %s..." % path
+print "Disconnect device %s..." % path
 device =3D dbus.Interface(bus.get_object('org.ofono.dundee', path),
 						'org.ofono.dundee.Device')
 =

-- =

1.7.9.5


--===============0404276621974271690==--

