Content-Type: multipart/mixed; boundary="===============8909717434716207915=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 04/16] elect: Add systemd configuration file
Date: Tue, 13 Dec 2011 15:59:58 +0100
Message-ID: <1323788410-9988-5-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8909717434716207915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am         |    6 ++++++
 elect/elect.service |   11 +++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 elect/elect.service

diff --git a/Makefile.am b/Makefile.am
index 70ea5de..43311b0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -661,6 +661,12 @@ if DATAFILES
 =

 dist_dbusconf_DATA +=3D elect/elect.conf
 =

+if SYSTEMD
+systemdunitdir +=3D @SYSTEMD_UNITDIR@
+
+systemdunit_DATA +=3D elect/elect.service
+endif
+
 endif
 =

 endif
diff --git a/elect/elect.service b/elect/elect.service
new file mode 100644
index 0000000..39d9349
--- /dev/null
+++ b/elect/elect.service
@@ -0,0 +1,11 @@
+[Unit]
+Description=3DDUN service
+After=3Dsyslog.target
+
+[Service]
+Type=3Ddbus
+BusName=3Dorg.ofono.elect
+ExecStart=3D/usr/sbin/electd -n
+
+[Install]
+WantedBy=3Dmulti-user.target
-- =

1.7.8.110.g4cb5d1


--===============8909717434716207915==--

