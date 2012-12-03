Content-Type: multipart/mixed; boundary="===============1772732666192257267=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 05/14] hfp_hf: Add Profile1 Release
Date: Mon, 03 Dec 2012 10:11:46 -0300
Message-ID: <1354540315-27731-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1354540315-27731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1772732666192257267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the Release method of the external Profile handler.
Release method gets called when BlueZ unregisters the HFP profile.
---
 plugins/hfp_hf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 644067c..dd09142 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -395,9 +395,13 @@ static DBusMessage *profile_release(DBusConnection *co=
nn,
 					DBusMessage *msg, void *data)
 {
 	DBG("Profile handler Release");
-	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-					".NotImplemented",
-					"Implementation not provided");
+
+	g_dbus_unregister_interface(connection, HFP_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
+
+	g_hash_table_foreach_remove(modem_hash, hfp_remove_modem, NULL);
+
+	return dbus_message_new_method_return(msg);
 }
 =

 static DBusMessage *profile_cancel(DBusConnection *conn,
-- =

1.7.11.7


--===============1772732666192257267==--

