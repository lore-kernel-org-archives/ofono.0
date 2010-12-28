Content-Type: multipart/mixed; boundary="===============8920693698991024176=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.uklinux.net>
Subject: [PATCH] doc: New file about using the calypso modem
Date: Tue, 28 Dec 2010 12:25:45 +0000
Message-ID: <1293539145-32734-1-git-send-email-neil@ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8920693698991024176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/calypso-modem.txt |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 doc/calypso-modem.txt

diff --git a/doc/calypso-modem.txt b/doc/calypso-modem.txt
new file mode 100644
index 0000000..ea3e0bb
--- /dev/null
+++ b/doc/calypso-modem.txt
@@ -0,0 +1,22 @@
+Calypso modem usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+On the Openmoko Freerunner phone, the Calypso modem is presented by
+the kernel as serial device /dev/ttySAC0.  To allow Ofono to
+autodetect and use this, a simple udev rule is needed:
+
+KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"calypso"
+
+You can put this in any file in /lib/udev/rules.d.  A logical choice
+is the "55-openmoko-gta01-gta02.rules" file, if it exists in your
+Freerunner distribution.
+
+With this rule in place:
+
+- ofono will detect the Calypso modem when it starts up, and the
+  `list-modems' test script will show this, but will not power it up
+
+- the `enable-modem' test script can be used to power it up
+
+- a subsequent `list-modems' will show lots of information, including
+  network registration.
-- =

1.7.1


--===============8920693698991024176==--

