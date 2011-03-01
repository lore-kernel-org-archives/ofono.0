Content-Type: multipart/mixed; boundary="===============6498577500444610957=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH v2] isimodem: removed unused NETWORK_TIMEOUT
Date: Tue, 01 Mar 2011 16:44:41 +0100
Message-ID: <1298994281-2950-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6498577500444610957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/network.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/network.h b/drivers/isimodem/network.h
index 822440c..a9c8a93 100644
--- a/drivers/isimodem/network.h
+++ b/drivers/isimodem/network.h
@@ -28,7 +28,6 @@ extern "C" {
 =

 #define PN_NETWORK					0x0A
 #define PN_MODEM_NETWORK				0xC8
-#define NETWORK_TIMEOUT					5
 #define NETWORK_SCAN_TIMEOUT				180
 #define NETWORK_SET_TIMEOUT				240
 #define NET_INVALID_TIME				0x64
-- =

1.7.2.3


--===============6498577500444610957==--

