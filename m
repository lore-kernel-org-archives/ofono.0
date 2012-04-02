Content-Type: multipart/mixed; boundary="===============3040068111374898813=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v6 07/16] dundee: Add systemd configuration file
Date: Mon, 02 Apr 2012 18:20:05 +0200
Message-ID: <1333383614-4921-8-git-send-email-wagi@monom.org>
In-Reply-To: <1333383614-4921-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3040068111374898813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am              |    6 ++++++
 configure.ac             |    3 ++-
 dundee/dundee.service.in |   11 +++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 dundee/dundee.service.in

diff --git a/Makefile.am b/Makefile.am
index ad61106..fb79a1d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -681,6 +681,12 @@ if DATAFILES
 =

 dist_dbusconf_DATA +=3D dundee/dundee.conf
 =

+if SYSTEMD
+
+systemdunit_DATA +=3D dundee/dundee.service
+
+endif
+
 endif
 =

 endif
diff --git a/configure.ac b/configure.ac
index 1e21cc4..acc8114 100644
--- a/configure.ac
+++ b/configure.ac
@@ -255,4 +255,5 @@ fi
 AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 			[Directory for the configuration files])
 =

-AC_OUTPUT(Makefile include/version.h src/ofono.service ofono.pc)
+AC_OUTPUT(Makefile include/version.h src/ofono.service ofono.pc \
+	   dundee/dundee.service)
diff --git a/dundee/dundee.service.in b/dundee/dundee.service.in
new file mode 100644
index 0000000..c57c618
--- /dev/null
+++ b/dundee/dundee.service.in
@@ -0,0 +1,11 @@
+[Unit]
+Description=3DDUN service
+After=3Dsyslog.target
+
+[Service]
+Type=3Ddbus
+BusName=3Dorg.ofono.dundee
+ExecStart=3D@prefix@/sbin/dundee -n
+
+[Install]
+WantedBy=3Dmulti-user.target
-- =

1.7.10.rc3.1.gb3065


--===============3040068111374898813==--

