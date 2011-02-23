Content-Type: multipart/mixed; boundary="===============5895336850295699646=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 04/18] plugins: add u8500 to udev
Date: Wed, 23 Feb 2011 12:43:15 +0100
Message-ID: <b3c1140fdbf2ebfe0179e21c1db2ff72ff5401b2.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5895336850295699646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 plugins/ofono.rules |    3 +++
 plugins/udev.c      |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 121825e..2e315a3 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -357,6 +357,9 @@ SUBSYSTEMS=3D=3D"usb", ENV{OFONO_DRIVER}=3D"isiusb", EN=
V{OFONO_ISI_ADDRESS}=3D"16"
 # Nokia N900 modem
 SUBSYSTEMS=3D=3D"hsi", ENV{OFONO_DRIVER}=3D"n900", ENV{OFONO_ISI_ADDRESS}=
=3D"108"
 =

+# STE u8500
+KERNEL=3D=3D"shrm0", ENV{OFONO_DRIVER}=3D"u8500"
+
 LABEL=3D"ofono_isi_end"
 =

 SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"
diff --git a/plugins/udev.c b/plugins/udev.c
index 84478d7..b73150e 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -666,6 +666,8 @@ done:
 		add_nokia(modem, udev_device);
 	else if (g_strcmp0(driver, "isiusb") =3D=3D 0)
 		add_isi(modem, udev_device);
+	else if (g_strcmp0(driver, "u8500") =3D=3D 0)
+		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "n900") =3D=3D 0)
 		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "gobi") =3D=3D 0)
-- =

1.7.3.5


--===============5895336850295699646==--

