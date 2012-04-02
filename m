Content-Type: multipart/mixed; boundary="===============6382633500019661574=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v6 06/16] dundee: Add D-Bus configuration file
Date: Mon, 02 Apr 2012 18:20:04 +0200
Message-ID: <1333383614-4921-7-git-send-email-wagi@monom.org>
In-Reply-To: <1333383614-4921-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6382633500019661574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am        |    6 ++++++
 dundee/dundee.conf |   23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 dundee/dundee.conf

diff --git a/Makefile.am b/Makefile.am
index fb0de75..ad61106 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -677,6 +677,12 @@ dundee_dundee_SOURCES =3D $(gdbus_sources) \
 =

 dundee_dundee_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_L=
IBS@ -ldl
 =

+if DATAFILES
+
+dist_dbusconf_DATA +=3D dundee/dundee.conf
+
+endif
+
 endif
 =

 noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
diff --git a/dundee/dundee.conf b/dundee/dundee.conf
new file mode 100644
index 0000000..de79dd5
--- /dev/null
+++ b/dundee/dundee.conf
@@ -0,0 +1,23 @@
+<!-- This configuration file specifies the required security policies
+     for oFono dundee (DUN) daemon to work. -->
+
+<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.=
0//EN"
+ "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
+<busconfig>
+
+  <!-- ../system.conf have denied everything, so we just punch some holes =
-->
+
+  <policy user=3D"root">
+    <allow own=3D"org.ofono.dundee"/>
+    <allow send_destination=3D"org.ofono.dundee"/>
+  </policy>
+
+  <policy at_console=3D"true">
+    <allow send_destination=3D"org.ofono.dundee"/>
+  </policy>
+
+  <policy context=3D"default">
+    <deny send_destination=3D"org.ofono.dundee"/>
+  </policy>
+
+</busconfig>
-- =

1.7.10.rc3.1.gb3065


--===============6382633500019661574==--

