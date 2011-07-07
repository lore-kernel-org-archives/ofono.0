Content-Type: multipart/mixed; boundary="===============6206886952553371517=="
MIME-Version: 1.0
From: Mario Tokarz <mario@tokarz.eu>
Subject: [RFC 2/3] bluetooth: Add UUID for DUN.
Date: Thu, 07 Jul 2011 10:45:22 +0200
Message-ID: <1310028323-29180-3-git-send-email-mario@tokarz.eu>
In-Reply-To: <1310028323-29180-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6206886952553371517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mario Tokarz <mario.tokarz@bmw-carit.de>

---
 plugins/bluetooth.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 7f9f810..f572e5d 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -27,9 +27,11 @@
 =

 #define DBUS_TIMEOUT 15
 =

+#define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 =

+
 struct bluetooth_profile {
 	const char *name;
 	int (*probe)(const char *device, const char *dev_addr,
-- =

1.7.4.1


--===============6206886952553371517==--

