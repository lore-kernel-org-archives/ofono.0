Content-Type: multipart/mixed; boundary="===============5003002630392435412=="
MIME-Version: 1.0
From: Ryan M. Raasch <ryan.raasch@gmail.com>
Subject: [PATCH 1/2] Added functionality to remove modem from system,
 if needed.
Date: Thu, 29 Oct 2009 14:54:33 +0100
Message-ID: <1256824474-31389-2-git-send-email-ryan.raasch@gmail.com>
In-Reply-To: <1256824474-31389-1-git-send-email-ryan.raasch@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5003002630392435412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/enable-modem |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/test/enable-modem b/test/enable-modem
index 0f9f604..d44783d 100755
--- a/test/enable-modem
+++ b/test/enable-modem
@@ -1,6 +1,7 @@
 #!/usr/bin/python
 =

 import dbus
+import sys
 =

 bus =3D dbus.SystemBus()
 =

@@ -14,4 +15,7 @@ path =3D properties["Modems"][0]
 modem =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.Modem')
 =

-modem.SetProperty("Powered", dbus.Boolean(1))
+if len(sys.argv) > 1 and sys.argv[1] =3D=3D '0' :
+    modem.SetProperty("Powered", dbus.Boolean(0))
+else :
+    modem.SetProperty("Powered", dbus.Boolean(1))
-- =

1.6.4.GIT


--===============5003002630392435412==--

