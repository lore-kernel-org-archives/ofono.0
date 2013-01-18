Content-Type: multipart/mixed; boundary="===============4680659614349060159=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 06/10] phonesim: Use hfp_slc_info_free()
Date: Fri, 18 Jan 2013 20:38:56 -0300
Message-ID: <1358552340-29393-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358552340-29393-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4680659614349060159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Now that we have a function that takes care of free'ing that structure
we should use it.
---
 plugins/phonesim.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 8631039..63590a9 100644
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
@@ -944,8 +943,7 @@ static int localhfp_disable(struct ofono_modem *modem)
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

1.7.11.7


--===============4680659614349060159==--

