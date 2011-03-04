Content-Type: multipart/mixed; boundary="===============2339820107863306739=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/2] huawei: do not check for NULL pointer
Date: Fri, 04 Mar 2011 10:10:13 -0300
Message-ID: <1299244214-12411-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2339820107863306739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

cb_data_new() uses g_new0(), hence there's no need to check the return
value being NULL.
---
 plugins/huawei.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 6f05677..afa804d 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -600,13 +600,9 @@ static void huawei_set_online(struct ofono_modem *mode=
m, ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-- =

1.7.4.1


--===============2339820107863306739==--

