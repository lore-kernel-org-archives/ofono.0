Content-Type: multipart/mixed; boundary="===============8406884868285574721=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Fix: remove extra comma from NotAvailable error
Date: Thu, 19 Aug 2010 19:20:26 +0300
Message-ID: <1282234826-30021-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8406884868285574721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/dbus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index 09114c3..c51f2a9 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -300,7 +300,7 @@ DBusMessage *__ofono_error_not_supported(DBusMessage *m=
sg)
 =

 DBusMessage *__ofono_error_not_available(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE,
+	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE
 					".NotAvailable",
 					"Operation currently not available");
 }
-- =

1.7.0.4


--===============8406884868285574721==--

