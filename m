Content-Type: multipart/mixed; boundary="===============0958025940627166284=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v5 07/16] dundee: Add systemd configuration file
Date: Wed, 04 Jan 2012 18:17:41 +0100
Message-ID: <1325697470-22227-8-git-send-email-wagi@monom.org>
In-Reply-To: <1325697470-22227-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0958025940627166284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am           |    6 ++++++
 dundee/dundee.service |   11 +++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 dundee/dundee.service

diff --git a/Makefile.am b/Makefile.am
index 742bde9..b335caa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -663,6 +663,12 @@ if DATAFILES
 =

 dist_dbusconf_DATA +=3D dundee/dundee.conf
 =

+if SYSTEMD
+systemdunitdir +=3D @SYSTEMD_UNITDIR@
+
+systemdunit_DATA +=3D dundee/dundee.service
+endif
+
 endif
 =

 endif
diff --git a/dundee/dundee.service b/dundee/dundee.service
new file mode 100644
index 0000000..1b8f323
--- /dev/null
+++ b/dundee/dundee.service
@@ -0,0 +1,11 @@
+[Unit]
+Description=3DDUN service
+After=3Dsyslog.target
+
+[Service]
+Type=3Ddbus
+BusName=3Dorg.ofono.dundee
+ExecStart=3D/usr/sbin/dundee -n
+
+[Install]
+WantedBy=3Dmulti-user.target
-- =

1.7.8.2.302.g17b4


--===============0958025940627166284==--

