Content-Type: multipart/mixed; boundary="===============0610136633790287731=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v4 07/16] dundee: Add systemd configuration file
Date: Tue, 20 Dec 2011 15:47:10 +0100
Message-ID: <1324392439-26508-8-git-send-email-wagi@monom.org>
In-Reply-To: <1324392439-26508-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0610136633790287731==
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
index 1b25daa..ea9733c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -661,6 +661,12 @@ if DATAFILES
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

1.7.8.110.g4cb5d1


--===============0610136633790287731==--

