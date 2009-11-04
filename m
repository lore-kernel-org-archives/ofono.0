Content-Type: multipart/mixed; boundary="===============4156659568840592062=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 1/1] handle werid mbm card network name
Date: Wed, 04 Nov 2009 13:33:40 +0800
Message-ID: <1257312820-8860-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4156659568840592062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index c2e9c41..345613b 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -120,7 +120,8 @@ static void add_mbm(struct ofono_modem *modem,
 		devnode =3D udev_device_get_devnode(udev_device);
 		ofono_modem_set_string(modem, GPS_DEVICE, devnode);
 	} else if (g_str_has_suffix(desc, "Minicard Network Adapter") ||
-			g_str_has_suffix(desc, "Broadband Network Adapter")) {
+			g_str_has_suffix(desc, "Broadband Network Adapter") ||
+				g_str_has_suffix(desc, "Minicard NetworkAdapter")) {
 		devnode =3D udev_device_get_property_value(udev_device,
 								"INTERFACE");
 		ofono_modem_set_string(modem, NETWORK_INTERFACE, devnode);
-- =

1.6.1.3


--===============4156659568840592062==--

