Content-Type: multipart/mixed; boundary="===============1347058967336216017=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Cl=C3=A9mentViel?= <vielclement@gmail.com>
Subject: [PATCH 3/3] sim800: adding documentation to inform about the udev
 rule the user must add
Date: Tue, 18 Sep 2018 22:36:27 +0200
Message-ID: <1537302987-12592-3-git-send-email-vielclement@gmail.com>
In-Reply-To: <1537302987-12592-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1347058967336216017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: clem <vielclement@gmail.com>

---
 doc/sim800-modem.txt | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 doc/sim800-modem.txt

diff --git a/doc/sim800-modem.txt b/doc/sim800-modem.txt
new file mode 100644
index 0000000..6731879
--- /dev/null
+++ b/doc/sim800-modem.txt
@@ -0,0 +1,7 @@
+SIM800 modem usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To enable SIM900 module support you need to put the following
+udev rule into appropriate file in /{etc,lib}/udev/rules.d:
+
+KERNEL=3D=3D"ttyUSB0", ENV{OFONO_DRIVER}=3D"sim800"
-- =

2.7.4


--===============1347058967336216017==--

