Content-Type: multipart/mixed; boundary="===============0317482752734537703=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v6 04/12] bluetooth: Add define for MediaTransport interface
Date: Wed, 01 Aug 2012 12:09:39 +0200
Message-ID: <1343815787-22670-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343815787-22670-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0317482752734537703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 6a2fbf0..ecc89c3 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -31,6 +31,7 @@
 #define BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
 #define	BLUEZ_TELEPHONY_INTERFACE	BLUEZ_SERVICE ".Telephony"
 #define	BLUEZ_TELEPHONY_AGENT_INTERFACE	BLUEZ_SERVICE ".TelephonyAgent"
+#define	BLUEZ_TRANSPORT_INTERFACE	BLUEZ_SERVICE ".MediaTransport"
 =

 #define DBUS_TIMEOUT 15
 =

-- =

1.7.9.5


--===============0317482752734537703==--

