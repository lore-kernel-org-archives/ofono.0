Content-Type: multipart/mixed; boundary="===============2967846337769586186=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH 1/1] isimodem: group timeouts in enum, remove unused timeout
Date: Sun, 06 Feb 2011 13:56:40 +0100
Message-ID: <1296997000-12073-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2967846337769586186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce enum network_timeout for scan/registration timeouts,
remove unused NETWORK_TIMEOUT.
---
 drivers/isimodem/network.h |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/isimodem/network.h b/drivers/isimodem/network.h
index b96216d..f35ed5a 100644
--- a/drivers/isimodem/network.h
+++ b/drivers/isimodem/network.h
@@ -27,11 +27,13 @@ extern "C" {
 #endif
 =

 #define PN_NETWORK					0x0A
-#define NETWORK_TIMEOUT					5
-#define NETWORK_SCAN_TIMEOUT				180
-#define NETWORK_SET_TIMEOUT				240
 #define NET_INVALID_TIME				0x64
 =

+enum network_timeout {
+	NETWORK_SCAN_TIMEOUT	=3D	180,
+	NETWORK_SET_TIMEOUT		=3D	240
+};
+
 enum net_message_id {
 	NET_SET_REQ =3D					0x07,
 	NET_SET_RESP =3D					0x08,
-- =

1.7.2.3


--===============2967846337769586186==--

