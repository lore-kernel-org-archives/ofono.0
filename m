Content-Type: multipart/mixed; boundary="===============1721406539396571135=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v1 09/10] phonesim: Use hfp_slc_info_free()
Date: Wed, 23 Jan 2013 15:28:00 -0300
Message-ID: <1358965681-7420-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358965681-7420-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1721406539396571135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that we have a function that takes care of free'ing that structure
we should use it.
---
 plugins/phonesim.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 9210e02..a9b77b9 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -885,8 +885,7 @@ static void slc_failed(gpointer userdata)
 =

 	ofono_modem_set_powered(modem, FALSE);
 =

-	g_at_chat_unref(info->chat);
-	info->chat =3D NULL;
+	hfp_slc_info_free(info);
 }
 =

 static int localhfp_enable(struct ofono_modem *modem)
@@ -940,8 +939,7 @@ static int localhfp_disable(struct ofono_modem *modem)
 {
 	struct hfp_slc_info *info =3D ofono_modem_get_data(modem);
 =

-	g_at_chat_unref(info->chat);
-	info->chat =3D NULL;
+	hfp_slc_info_free(info);
 =

 	return 0;
 }
-- =

1.8.1.1


--===============1721406539396571135==--

