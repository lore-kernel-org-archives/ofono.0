Content-Type: multipart/mixed; boundary="===============8662329927643005577=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 6/6] test: add support to select modem
Date: Thu, 29 Sep 2011 14:54:26 -0300
Message-ID: <1317318866-9027-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317318866-9027-5-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8662329927643005577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 test/test-phonebook |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/test/test-phonebook b/test/test-phonebook
index 183394c..345ba67 100755
--- a/test/test-phonebook
+++ b/test/test-phonebook
@@ -1,15 +1,23 @@
 #!/usr/bin/python
 =

-import dbus
+import dbus, sys
 =

 if __name__ =3D=3D "__main__":
 	bus =3D dbus.SystemBus()
 =

+	if len(sys.argv) =3D=3D 2:
+		path =3D sys.argv[1]
+	else:
+		manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+				'org.ofono.Manager')
+		modems =3D manager.GetModems()
+		path =3D modems[0][0]
+
 	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
 							'org.ofono.Manager')
 =

 	modems =3D manager.GetModems()
-	phonebook =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
+	phonebook =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.Phonebook')
 =

 	print phonebook.Import(timeout=3D100)
-- =

1.7.6.2


--===============8662329927643005577==--

