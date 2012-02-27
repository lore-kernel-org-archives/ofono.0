Content-Type: multipart/mixed; boundary="===============0581503319703085418=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: [PATCH] hso: Don't access freed data, in hso_set_online
Date: Mon, 27 Feb 2012 20:04:43 +0000
Message-ID: <1330373083-1223-1-git-send-email-neil@ossau.homelinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0581503319703085418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hso.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/hso.c b/plugins/hso.c
index 497c64e..249bb2c 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -421,9 +421,9 @@ static void hso_set_online(struct ofono_modem *modem, o=
fono_bool_t online,
 	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
 		return;
 =

-	g_free(cbd);
-
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
 }
 =

 static void hso_pre_sim(struct ofono_modem *modem)
-- =

1.7.9


--===============0581503319703085418==--

