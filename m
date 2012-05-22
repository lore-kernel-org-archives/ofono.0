Content-Type: multipart/mixed; boundary="===============2354734977224568956=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v7 07/16] dundee: Add systemd configuration file
Date: Tue, 22 May 2012 18:33:15 +0200
Message-ID: <1337704404-5260-8-git-send-email-wagi@monom.org>
In-Reply-To: <1337704404-5260-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2354734977224568956==
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
index ee83faa..31e0110 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -697,6 +697,12 @@ if DATAFILES
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
index 0377298..d2092b9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -242,4 +242,5 @@ fi
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

1.7.10.130.g36e6c


--===============2354734977224568956==--

