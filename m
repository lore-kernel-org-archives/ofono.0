Content-Type: multipart/mixed; boundary="===============0882183797821926568=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v1 05/15] hfp_hf: Add Profile1 Release
Date: Mon, 26 Nov 2012 10:26:59 -0300
Message-ID: <1353936429-9997-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353936429-9997-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0882183797821926568==
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


--===============0882183797821926568==--

