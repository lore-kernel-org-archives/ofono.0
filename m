Content-Type: multipart/mixed; boundary="===============8995940495590002283=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v5 06/16] dundee: Add D-Bus configuration file
Date: Wed, 04 Jan 2012 18:17:40 +0100
Message-ID: <1325697470-22227-7-git-send-email-wagi@monom.org>
In-Reply-To: <1325697470-22227-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8995940495590002283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am        |    6 ++++++
 dundee/dundee.conf |   23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 dundee/dundee.conf

diff --git a/Makefile.am b/Makefile.am
index da456ed..742bde9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -659,6 +659,12 @@ dundee_dundee_SOURCES =3D $(gdbus_sources) \
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

1.7.8.2.302.g17b4


--===============8995940495590002283==--

