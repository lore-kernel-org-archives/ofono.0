Content-Type: multipart/mixed; boundary="===============0661392603978603575=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: [PATCH 2/3] sim800: add documentation and modify AUTHORS file
Date: Wed, 03 Oct 2018 15:28:22 +0200
Message-ID: <1538573303-4560-2-git-send-email-vielclement@gmail.com>
In-Reply-To: <1538573303-4560-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0661392603978603575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 AUTHORS              |  1 +
 doc/sim800-modem.txt | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 doc/sim800-modem.txt

diff --git a/AUTHORS b/AUTHORS
index 2d360e6..a8362c8 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -138,3 +138,4 @@ Florent Beillonnet <florent.beillonnet@gmail.com>
 Martin Hundeb=C3=B8ll <martin@geanix.com>
 Julien Tournier <tournier.julien@gmail.com>
 Nandini Rebello <nandini.rebello@intel.com>
+Clement Viel <vielclement@gmail.com>
diff --git a/doc/sim800-modem.txt b/doc/sim800-modem.txt
new file mode 100644
index 0000000..7220cb8
--- /dev/null
+++ b/doc/sim800-modem.txt
@@ -0,0 +1,11 @@
+SIM800 modem usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To enable SIM800 module support you need to put the following
+udev rule into appropriate file in /{etc,lib}/udev/rules.d:
+
+KERNEL=3D=3D"ttyS2", ENV{OFONO_DRIVER}=3D"sim800"
+
+Sim800 driver code is merged with sim900's. So, to add modifications to si=
m800 driver, sim900.c file must be edited
+accordingly.
+To differentiate the two modems, developpers must use the "modem_type" fie=
ld of sim900_data structure.
-- =

2.7.4


--===============0661392603978603575==--

