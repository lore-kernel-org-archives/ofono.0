Content-Type: multipart/mixed; boundary="===============3923283149284420756=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 2/3] bluetooth: Add PAN UUID
Date: Mon, 04 Jun 2012 16:11:31 +0200
Message-ID: <1338819092-28696-3-git-send-email-wagi@monom.org>
In-Reply-To: <1338819092-28696-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3923283149284420756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/bluetooth.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index c06abf7..e801bfc 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -32,6 +32,7 @@
 #define DBUS_TIMEOUT 15
 =

 #define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
+#define NAP_UUID	"00001116-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 #define SAP_UUID	"0000112d-0000-1000-8000-00805f9b34fb"
-- =

1.7.10.130.g36e6c


--===============3923283149284420756==--

