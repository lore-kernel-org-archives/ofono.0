Content-Type: multipart/mixed; boundary="===============0921608989949048444=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 5/6] test: Add ReportChanged to monitored signals
Date: Wed, 12 Sep 2012 15:55:12 +0200
Message-ID: <1347458113-29039-6-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1347458113-29039-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0921608989949048444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/monitor-mms |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/test/monitor-mms b/test/monitor-mms
index 188d028..ab77765 100755
--- a/test/monitor-mms
+++ b/test/monitor-mms
@@ -29,6 +29,13 @@ def property_changed(name, value, member, path, interfac=
e):
 	iface =3D interface[interface.rfind(".") + 1:]
 	print "{%s} [%s] %s %s" % (iface, name, member, value)

+def report_changed(type, status, details, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] <%s> : %s" % (iface, path, type, status)
+	for key in details.keys():
+		val =3D str(details[key])
+		print "    %s =3D> %s" % (key, val)
+
 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)

@@ -75,5 +82,11 @@ if __name__ =3D=3D '__main__':
 						path_keyword=3D"path",
 						interface_keyword=3D"interface")

+	bus.add_signal_receiver(report_changed,
+					bus_name=3D"org.ofono.mms",
+					signal_name =3D "ReportChanged",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
--
1.7.9.5


--===============0921608989949048444==--

