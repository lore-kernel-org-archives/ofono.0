Content-Type: multipart/mixed; boundary="===============3524751782470213768=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: [PATCH] test: shows the id of the modem beeing enabled/disabled
Date: Wed, 24 Feb 2010 16:14:25 -0300
Message-ID: <1267038867-28929-1-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3524751782470213768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/disable-modem |    1 +
 test/enable-modem  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/test/disable-modem b/test/disable-modem
index 47b8531..a1611ec 100755
--- a/test/disable-modem
+++ b/test/disable-modem
@@ -13,6 +13,7 @@ else:
 	properties =3D manager.GetProperties()
 	path =3D properties["Modems"][0]
 =

+print "Disconnecting modem %s..." % path
 modem =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.Modem')
 =

diff --git a/test/enable-modem b/test/enable-modem
index 86362af..02dc150 100755
--- a/test/enable-modem
+++ b/test/enable-modem
@@ -13,6 +13,7 @@ else:
 	properties =3D manager.GetProperties()
 	path =3D properties["Modems"][0]
 =

+print "Connecting modem %s..." % path
 modem =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.Modem')
 =

-- =

1.6.3.3


--===============3524751782470213768==--

