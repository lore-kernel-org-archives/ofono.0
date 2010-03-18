Content-Type: multipart/mixed; boundary="===============2969168324527416980=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: [PATCH] huawei: use GSM permissive parser instead of V1.
Date: Thu, 18 Mar 2010 17:45:31 -0300
Message-ID: <1268945131-3333-1-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2969168324527416980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With V1 parser the driver fails to detect when a SMS is successfully
sent and keeps re-trying until Max retries.
---
 plugins/huawei.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 1492446..41ad636 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -107,7 +107,7 @@ static int huawei_enable(struct ofono_modem *modem)
 	if (!channel)
 		return -EIO;
 =

-	syntax =3D g_at_syntax_new_gsmv1();
+	syntax =3D g_at_syntax_new_gsm_permissive();
 	data->chat =3D g_at_chat_new(channel, syntax);
 	g_at_syntax_unref(syntax);
 	g_io_channel_unref(channel);
-- =

1.6.3.3


--===============2969168324527416980==--

