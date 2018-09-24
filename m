Content-Type: multipart/mixed; boundary="===============0702397813548775858=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: [PATCH 3/3] sim800: adding documentation and updating AUTHORS
Date: Tue, 25 Sep 2018 00:43:30 +0200
Message-ID: <1537829010-15668-3-git-send-email-vielclement@gmail.com>
In-Reply-To: <1537829010-15668-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0702397813548775858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: clem <vielclement@gmail.com>

---
 AUTHORS              | 1 +
 doc/sim800-modem.txt | 7 +++++++
 2 files changed, 8 insertions(+)
 create mode 100644 doc/sim800-modem.txt

diff --git a/AUTHORS b/AUTHORS
index 52f46e9..c5fa295 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -137,3 +137,4 @@ Varun Gargi <varun.gargi@intel.com>
 Florent Beillonnet <florent.beillonnet@gmail.com>
 Martin Hundeb=C3=B8ll <martin@geanix.com>
 Julien Tournier <tournier.julien@gmail.com>
+Clement Viel <vielclement@gmail.com>
diff --git a/doc/sim800-modem.txt b/doc/sim800-modem.txt
new file mode 100644
index 0000000..94bf573
--- /dev/null
+++ b/doc/sim800-modem.txt
@@ -0,0 +1,7 @@
+SIM800 modem usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To enable SIM800 module support you need to put the following
+udev rule into appropriate file in /{etc,lib}/udev/rules.d:
+
+KERNEL=3D=3D"gsmtty3", ENV{OFONO_DRIVER}=3D"sim800"
-- =

2.7.4


--===============0702397813548775858==--

