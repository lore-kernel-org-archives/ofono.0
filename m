Content-Type: multipart/mixed; boundary="===============3018230665218054851=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 11/12] test: Add ReportChanged to monitored signals
Date: Fri, 24 Aug 2012 15:06:10 +0200
Message-ID: <1345813571-15775-12-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345813571-15775-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3018230665218054851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/monitor-mms |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/test/monitor-mms b/test/monitor-mms
index 188d028..ef17a13 100755
--- a/test/monitor-mms
+++ b/test/monitor-mms
@@ -29,6 +29,10 @@ def property_changed(name, value, member, path, interfac=
e):
 	iface =3D interface[interface.rfind(".") + 1:]
 	print "{%s} [%s] %s %s" % (iface, name, member, value)
 =

+def report_changed(type, rec, status, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] <%s> %s : %s" % (iface, path, type, rec, status)
+
 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 =

@@ -75,5 +79,11 @@ if __name__ =3D=3D '__main__':
 						path_keyword=3D"path",
 						interface_keyword=3D"interface")
 =

+	bus.add_signal_receiver(report_changed,
+					bus_name=3D"org.ofono.mms",
+					signal_name =3D "ReportChanged",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
-- =

1.7.9.5


--===============3018230665218054851==--

