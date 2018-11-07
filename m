Content-Type: multipart/mixed; boundary="===============4668982328430736200=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: [PATCH 2/3] sim800: add documentation.
Date: Wed, 07 Nov 2018 11:14:29 +0100
Message-ID: <1541585670-3551-2-git-send-email-vielclement@gmail.com>
In-Reply-To: <1541585670-3551-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4668982328430736200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim800-modem.txt | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 doc/sim800-modem.txt

diff --git a/doc/sim800-modem.txt b/doc/sim800-modem.txt
new file mode 100644
index 0000000..a299e97
--- /dev/null
+++ b/doc/sim800-modem.txt
@@ -0,0 +1,7 @@
+SIM800 modem usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To enable SIM800 module support you need to put the following
+udev rule into appropriate file in /{etc,lib}/udev/rules.d:
+
+KERNEL=3D=3D"ttyS0", ENV{OFONO_DRIVER}=3D"sim800"
-- =

2.7.4


--===============4668982328430736200==--

