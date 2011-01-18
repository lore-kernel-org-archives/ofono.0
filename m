Content-Type: multipart/mixed; boundary="===============6988356220184941872=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: [PATCH] ste: Use UTF-8 as a default character set
Date: Tue, 18 Jan 2011 15:38:24 +0200
Message-ID: <1295357904-16620-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6988356220184941872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ste.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 7bb7232..cc01f7b 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -247,7 +247,7 @@ static int ste_enable(struct ofono_modem *modem)
 		return -EIO;
 =

 	data->chat =3D g_at_chat_new_blocking(channel, syntax);
-	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
+	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1;+CSCS=3D\"UTF-8\"=
",
 			NULL, NULL, NULL, NULL);
 =

 	g_io_channel_unref(channel);
-- =

1.7.0.4


--===============6988356220184941872==--

