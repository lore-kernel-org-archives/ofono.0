Content-Type: multipart/mixed; boundary="===============7455488199235591089=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 1/3] bluetooth: use lower case for UUIDs
Date: Fri, 01 Jul 2011 10:12:22 +0300
Message-ID: <1309504344-23058-1-git-send-email-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7455488199235591089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BlueZ also uses lower case
---
 plugins/bluetooth.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 505d908..318e4b0 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -27,7 +27,7 @@
 =

 #define DBUS_TIMEOUT 15
 =

-#define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
+#define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 =

 /* Profiles bitfield */
 #define HFP_AG 0x01
-- =

1.7.5.4


--===============7455488199235591089==--

