Content-Type: multipart/mixed; boundary="===============6887100167648039724=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 05/11] hfp_hf: Add Profile1 Release
Date: Thu, 22 Nov 2012 14:53:22 -0300
Message-ID: <1353606808-25032-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353606808-25032-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6887100167648039724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the Release method of the external Profile handler.
Release method gets called when BlueZ unregisters the HFP profile.
---
 plugins/hfp_hf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 819c8cd..c536691 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -395,6 +395,12 @@ static DBusMessage *profile_release(DBusConnection *co=
nn,
 					DBusMessage *msg, void *data)
 {
 	DBG("Profile handler Release");
+
+	g_dbus_unregister_interface(connection, HFP_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
+
+	g_hash_table_foreach_remove(modem_hash, hfp_remove_modem, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 =

-- =

1.7.11.7


--===============6887100167648039724==--

