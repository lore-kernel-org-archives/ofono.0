Content-Type: multipart/mixed; boundary="===============4635067853809213070=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: [PATCH 2/3] sim800: merge sim800 and sim900 documentation.
Date: Mon, 12 Nov 2018 21:32:54 +0100
Message-ID: <1542054775-10576-2-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4635067853809213070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim900-modem.txt | 12 ------------
 doc/simcom-modem.txt | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 12 deletions(-)
 delete mode 100644 doc/sim900-modem.txt
 create mode 100644 doc/simcom-modem.txt

diff --git a/doc/sim900-modem.txt b/doc/sim900-modem.txt
deleted file mode 100644
index e9f051c..0000000
--- a/doc/sim900-modem.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-SIM900 modem usage
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-To enable SIM900 module support you need to put the following
-udev rule into appropriate file in /{etc,lib}/udev/rules.d:
-
-KERNEL=3D=3D"gsmtty3", ENV{OFONO_DRIVER}=3D"sim900"
-
-On the i-Tetra tracking device, the SIM900 is accessed
-via N_GSM mux device. We use ofono as SMS message
-service and incoming voice calls service, so we
-use /dev/gsmtty1 provided by N_GSM mux.
diff --git a/doc/simcom-modem.txt b/doc/simcom-modem.txt
new file mode 100644
index 0000000..0a81307
--- /dev/null
+++ b/doc/simcom-modem.txt
@@ -0,0 +1,22 @@
+SIM900 modem usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To enable SIM900 module support you need to put the following
+udev rule into appropriate file in /{etc,lib}/udev/rules.d:
+
+KERNEL=3D=3D"gsmtty3", ENV{OFONO_DRIVER}=3D"sim900"
+
+On the i-Tetra tracking device, the SIM900 is accessed
+via N_GSM mux device. We use ofono as SMS message
+service and incoming voice calls service, so we
+use /dev/gsmtty1 provided by N_GSM mux.
+
+SIM800 modem usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+When using sim800 modem, the udev rule is the same as the
+sim900 rule :
+
+KERNEL=3D=3D"ttyS3", ENV{OFONO_DRIVER}=3D"sim900"
+
+Because the SIM800 and SIM900 code are the merged into one driver.
-- =

2.7.4


--===============4635067853809213070==--

