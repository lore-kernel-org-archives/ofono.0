Content-Type: multipart/mixed; boundary="===============0557338675324469902=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 03/16] elect: Add D-Bus configuration file
Date: Tue, 13 Dec 2011 15:59:57 +0100
Message-ID: <1323788410-9988-4-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0557338675324469902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am      |    6 ++++++
 elect/elect.conf |   23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 elect/elect.conf

diff --git a/Makefile.am b/Makefile.am
index 38e5d90..70ea5de 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -657,6 +657,12 @@ elect_electd_SOURCES =3D $(gdbus_sources) \
 =

 elect_electd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LI=
BS@ -ldl
 =

+if DATAFILES
+
+dist_dbusconf_DATA +=3D elect/elect.conf
+
+endif
+
 endif
 =

 noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
diff --git a/elect/elect.conf b/elect/elect.conf
new file mode 100644
index 0000000..548ffe8
--- /dev/null
+++ b/elect/elect.conf
@@ -0,0 +1,23 @@
+<!-- This configuration file specifies the required security policies
+     for oFono elect (DUN) daemon to work. -->
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
+    <allow own=3D"org.ofono.elect"/>
+    <allow send_destination=3D"org.ofono.elect"/>
+  </policy>
+
+  <policy at_console=3D"true">
+    <allow send_destination=3D"org.ofono.elect"/>
+  </policy>
+
+  <policy context=3D"default">
+    <deny send_destination=3D"org.ofono.elect"/>
+  </policy>
+
+</busconfig>
-- =

1.7.8.110.g4cb5d1


--===============0557338675324469902==--

