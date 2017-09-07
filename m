Content-Type: multipart/mixed; boundary="===============1615074219184171864=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 7/7] test: added script to test serving cell agent
Date: Thu, 07 Sep 2017 09:53:20 +0530
Message-ID: <1504758200-18624-7-git-send-email-nishanth.v@intel.com>
In-Reply-To: <1504758200-18624-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1615074219184171864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                 |  4 +-
 test/test-serving-cell-info | 98 +++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 test/test-serving-cell-info

diff --git a/Makefile.am b/Makefile.am
index fbc4d6d..c46e85a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -780,7 +780,9 @@ test_scripts =3D test/backtrace \
 		test/list-allowed-access-points \
 		test/enable-throttling \
 		test/disable-throttling \
-		test/set-lte-property
+		test/set-lte-property \
+		test/test-serving-cell-info
+
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/test-serving-cell-info b/test/test-serving-cell-info
new file mode 100644
index 0000000..de9cb7b
--- /dev/null
+++ b/test/test-serving-cell-info
@@ -0,0 +1,98 @@
+#!/usr/bin/python3
+
+from gi.repository import GLib
+
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+NETMON_INTERFACE =3D "org.ofono.NetworkMonitor"
+AGENT_INTERFACE =3D "org.ofono.NetworkMonitorAgent"
+
+class NetworkMonitorAgent(dbus.service.Object):
+	@dbus.service.method(AGENT_INTERFACE,
+				in_signature=3D"", out_signature=3D"")
+	def Release(self):
+		print("Agent Released")
+		mainloop.quit()
+
+	@dbus.service.method(AGENT_INTERFACE,
+				in_signature=3D"a{sv}", out_signature=3D"")
+	def ServingCellInformationChanged(self, servingcell):
+		print("ServingCellInformationChanged notification recieved")
+
+		tech =3D 'Technology'
+		mcc =3D 'MobileCountryCode'
+		mnc =3D 'MobileNetworkCode'
+		lac =3D 'LocationAreaCode'
+		cid =3D 'CellId'
+		psc =3D 'PrimaryScramblingCode'
+		rssi =3D 'Strength'
+		ber =3D 'BitErrorRate'
+
+		if tech in servingcell:
+			print("    [ Radio Access Technology =3D %s]" \
+				% (servingcell[tech]))
+
+		if mcc in servingcell:
+			print("    [ Mobile Country Code =3D %s]" \
+				% (servingcell[mcc]))
+
+		if mnc in servingcell:
+			print("    [ Mobile Network Code =3D %s]" \
+				% (servingcell[mnc]))
+
+		if lac in servingcell:
+			print("    [ Location Area Code =3D %d]" \
+				% (servingcell[lac]))
+
+		if cid in servingcell:
+			print("    [ Cell Identity =3D %d]" \
+				% (servingcell[cid]))
+
+		if psc in servingcell:
+			print("    [ Primary Scrambling Code =3D %d]" \
+				% (servingcell[psc]))
+
+		if rssi in servingcell:
+			print("    [ Signal Strength =3D %d]" \
+				% (servingcell[rssi]))
+
+		if ber in servingcell:
+			print("    [ Bit Error Rate =3D %d]" \
+				% (servingcell[ber]))
+
+		print('')
+	=

+if __name__ =3D=3D '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	if len(sys.argv) < 2:
+		print("Usage: %s <update_period_in_seconds>" %\
+				(sys.argv[0]))
+		sys.exit(1)
+
+	bus =3D dbus.SystemBus()
+	manager =3D dbus.Interface(bus.get_object("org.ofono", "/"),
+							"org.ofono.Manager")
+
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+	nm =3D dbus.Interface(bus.get_object('org.ofono', path),
+					NETMON_INTERFACE)
+	=

+	path =3D "/test/netmonagent"
+	agent =3D NetworkMonitorAgent(bus, path)
+
+	try:
+		period =3D int(sys.argv[1])
+	except:
+		print("Error: Invalid argument %s" % (sys.argv[1]))
+		sys.exit(1)
+
+	nm.RegisterAgent(path, period)
+	print("Agent registered")
+	mainloop =3D GLib.MainLoop()
+	mainloop.run()
+	=

-- =

1.9.1


--===============1615074219184171864==--

