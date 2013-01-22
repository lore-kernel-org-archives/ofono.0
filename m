Content-Type: multipart/mixed; boundary="===============3691295457320487452=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 08/10] hfp_hf_bluez4: Use hfp_slc_info_free()
Date: Tue, 22 Jan 2013 18:43:23 -0300
Message-ID: <1358891005-24688-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358891005-24688-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3691295457320487452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that we have a function that takes care of free'ing that structure
we should use it.
---
 plugins/hfp_hf_bluez4.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/plugins/hfp_hf_bluez4.c b/plugins/hfp_hf_bluez4.c
index b0aa1aa..ca73eaa 100644
--- a/plugins/hfp_hf_bluez4.c
+++ b/plugins/hfp_hf_bluez4.c
@@ -109,8 +109,10 @@ static void slc_failed(gpointer userdata)
 	ofono_error("Service level connection failed");
 	ofono_modem_set_powered(modem, FALSE);
 =

-	g_at_chat_unref(data->info->chat);
-	data->info->chat =3D NULL;
+	if (data->info) {
+		hfp_slc_info_free(data->info);
+		data->info =3D NULL;
+	}
 }
 =

 static void hfp_disconnected_cb(gpointer user_data)
@@ -120,8 +122,10 @@ static void hfp_disconnected_cb(gpointer user_data)
 =

 	ofono_modem_set_powered(modem, FALSE);
 =

-	g_at_chat_unref(data->info->chat);
-	data->info->chat =3D NULL;
+	if (data->info) {
+		hfp_slc_info_free(data->info);
+		data->info =3D NULL;
+	}
 }
 =

 /* either oFono or Phone could request SLC connection */
@@ -463,8 +467,10 @@ static int hfp_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_unref(data->info->chat);
-	data->info->chat =3D NULL;
+	if (data->info) {
+		hfp_slc_info_free(data->info);
+		data->info =3D NULL;
+	}
 =

 	if (data->agent_registered) {
 		status =3D bluetooth_send_with_reply(data->handsfree_path,
-- =

1.8.1.1


--===============3691295457320487452==--

