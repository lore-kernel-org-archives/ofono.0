Content-Type: multipart/mixed; boundary="===============2429935186508971310=="
MIME-Version: 1.0
From: Ryan M. Raasch <ryan.raasch@gmail.com>
Subject: [PATCH 2/2] This patch enables the pin number and type of pin to be
 sent to daemon to unlock the sim card.
Date: Thu, 29 Oct 2009 14:54:34 +0100
Message-ID: <1256824474-31389-3-git-send-email-ryan.raasch@gmail.com>
In-Reply-To: <1256824474-31389-1-git-send-email-ryan.raasch@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2429935186508971310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/enable-sim |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100755 test/enable-sim

diff --git a/test/enable-sim b/test/enable-sim
new file mode 100755
index 0000000..bbfd34f
--- /dev/null
+++ b/test/enable-sim
@@ -0,0 +1,18 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+properties =3D manager.GetProperties()
+
+path =3D properties["Modems"][0]
+
+modem =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.SimManager')
+
+modem.EnterPin(sys.argv[1], sys.argv[2])
-- =

1.6.4.GIT


--===============2429935186508971310==--

