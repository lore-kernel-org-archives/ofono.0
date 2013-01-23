Content-Type: multipart/mixed; boundary="===============0152962729326943216=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v1 08/10] hfp_hf_bluez4: Use hfp_slc_info_free()
Date: Wed, 23 Jan 2013 15:27:59 -0300
Message-ID: <1358965681-7420-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358965681-7420-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0152962729326943216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that we have a function that takes care of free'ing that structure
we should use it.
---
 plugins/hfp_hf_bluez4.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/plugins/hfp_hf_bluez4.c b/plugins/hfp_hf_bluez4.c
index b0aa1aa..d00e019 100644
--- a/plugins/hfp_hf_bluez4.c
+++ b/plugins/hfp_hf_bluez4.c
@@ -109,8 +109,8 @@ static void slc_failed(gpointer userdata)
 	ofono_error("Service level connection failed");
 	ofono_modem_set_powered(modem, FALSE);
 =

-	g_at_chat_unref(data->info->chat);
-	data->info->chat =3D NULL;
+	hfp_slc_info_free(data->info);
+	data->info =3D NULL;
 }
 =

 static void hfp_disconnected_cb(gpointer user_data)
@@ -120,8 +120,8 @@ static void hfp_disconnected_cb(gpointer user_data)
 =

 	ofono_modem_set_powered(modem, FALSE);
 =

-	g_at_chat_unref(data->info->chat);
-	data->info->chat =3D NULL;
+	hfp_slc_info_free(data->info);
+	data->info =3D NULL;
 }
 =

 /* either oFono or Phone could request SLC connection */
@@ -369,6 +369,8 @@ static void hfp_remove(struct ofono_modem *modem)
 					HFP_AGENT_INTERFACE))
 		hfp_unregister_ofono_handsfree(modem);
 =

+	hfp_slc_info_free(data->info);
+
 	g_free(data->handsfree_address);
 	g_free(data->handsfree_path);
 	g_free(data);
@@ -463,8 +465,8 @@ static int hfp_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_unref(data->info->chat);
-	data->info->chat =3D NULL;
+	hfp_slc_info_free(data->info);
+	data->info =3D NULL;
 =

 	if (data->agent_registered) {
 		status =3D bluetooth_send_with_reply(data->handsfree_path,
-- =

1.8.1.1


--===============0152962729326943216==--

