Content-Type: multipart/mixed; boundary="===============3845791571423277923=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 1/3] hfp_hf_bluez5: Add active SLC connections list
Date: Fri, 01 Feb 2013 14:51:36 -0300
Message-ID: <1359741098-27338-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359741098-27338-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3845791571423277923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a list to track the address of the active connections.
The list element contains a reference to the modem with active SLC
connections. Instead of storing a simple structure to identity the
Bluetooth address peer, the modem pointer is stored in the list since
it will be necessary to keep a reference for the SCO channel established.

This approach assumes that the remote Bluetooth device will not support
multiple active connections with multiple Bluetooth adapters available
in the same host.
---
 plugins/hfp_hf_bluez5.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2f4a89e..abeeb4a 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -64,6 +64,7 @@ struct hfp {
 };
 =

 static GHashTable *modem_hash =3D NULL;
+static GSList *slc_list =3D NULL;		/* Modem with active SLC connection */
 static GDBusClient *bluez =3D NULL;
 static guint sco_watch =3D 0;
 =

@@ -88,6 +89,8 @@ static void slc_established(gpointer userdata)
 	hfp->msg =3D NULL;
 =

 	ofono_info("Service level connection established");
+
+	slc_list =3D g_slist_prepend(slc_list, modem);
 }
 =

 static void slc_failed(gpointer userdata)
@@ -124,6 +127,8 @@ static void hfp_disconnected_cb(gpointer user_data)
 =

 	g_at_chat_unref(info->chat);
 	info->chat =3D NULL;
+
+	slc_list =3D g_slist_remove(slc_list, modem);
 }
 =

 static int service_level_connection(struct ofono_modem *modem,
@@ -612,6 +617,7 @@ static void hfp_exit(void)
 	ofono_modem_driver_unregister(&hfp_driver);
 	g_dbus_client_unref(bluez);
 =

+	g_slist_free(slc_list);
 	g_hash_table_destroy(modem_hash);
 =

 	if (sco_watch > 0)
-- =

1.7.11.7


--===============3845791571423277923==--

