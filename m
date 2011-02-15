Content-Type: multipart/mixed; boundary="===============1986344926240793647=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 06/18] plugins: add u8500 to udev
Date: Tue, 15 Feb 2011 13:31:00 +0100
Message-ID: <6727cc0e478f0d3252739a9e9cfb1736a8773eb1.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1986344926240793647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 plugins/ofono.rules |    3 +++
 plugins/udev.c      |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index f01b739..1090cf7 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -356,6 +356,9 @@ SUBSYSTEMS=3D=3D"usb", ENV{OFONO_DRIVER}=3D"isiusb", EN=
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


--===============1986344926240793647==--

