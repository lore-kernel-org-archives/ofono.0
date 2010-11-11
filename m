Content-Type: multipart/mixed; boundary="===============7104963315584961473=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] monitor-ofono: monitor DisconnectReason
Date: Thu, 11 Nov 2010 14:54:24 +0200
Message-ID: <1289480064-30384-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7104963315584961473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 test/monitor-ofono |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/test/monitor-ofono b/test/monitor-ofono
index 2f49f76..8570c34 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -75,6 +75,10 @@ def ussd(msg, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
 	print "{%s} [%s] %s %s" % (iface, path, member, str(msg))
 =

+def value(value, member, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] %s %s" % (iface, path, member, str(value))
+
 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 =

@@ -150,6 +154,13 @@ if __name__ =3D=3D '__main__':
 						path_keyword=3D"path",
 						interface_keyword=3D"interface")
 =

+	bus.add_signal_receiver(value,
+				bus_name=3D"org.ofono",
+					signal_name =3D "DisconnectReason",
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
 	for member in ["IncomingBroadcast", "EmergencyBroadcast",
 			"IncomingMessage", "ImmediateMessage"]:
 		bus.add_signal_receiver(message,
-- =

1.7.1


--===============7104963315584961473==--

