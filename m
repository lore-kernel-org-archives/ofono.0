Content-Type: multipart/mixed; boundary="===============1389059744351426056=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: [PATCH] cinterion: Correct use of freed structure
Date: Wed, 13 May 2015 17:08:47 +0100
Message-ID: <1431533327-8844-1-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1389059744351426056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On error struct cb_data *cbd was used after in cinterion_set_online
after already being freed.
---
 plugins/cinterion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/cinterion.c b/plugins/cinterion.c
index 6d85189..a18b9fe 100644
--- a/plugins/cinterion.c
+++ b/plugins/cinterion.c
@@ -166,9 +166,9 @@ static void cinterion_set_online(struct ofono_modem *mo=
dem, ofono_bool_t online,
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

 static void cinterion_pre_sim(struct ofono_modem *modem)
-- =

1.9.1


--===============1389059744351426056==--

