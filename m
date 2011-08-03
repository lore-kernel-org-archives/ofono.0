Content-Type: multipart/mixed; boundary="===============3365226319980201837=="
MIME-Version: 1.0
From: mario@tokarz.eu
Subject: [PATCH 1/2] bluetooth: Add UUID for DUN.
Date: Wed, 03 Aug 2011 13:48:29 +0200
Message-ID: <1312372110-23541-2-git-send-email-mario@tokarz.eu>
In-Reply-To: <1312372110-23541-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3365226319980201837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mario Tokarz <mario.tokarz@bmw-carit.de>

---
 plugins/bluetooth.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 7f9f810..6b3fef2 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -27,6 +27,7 @@
 =

 #define DBUS_TIMEOUT 15
 =

+#define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 =

-- =

1.7.4.1


--===============3365226319980201837==--

