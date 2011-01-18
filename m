Content-Type: multipart/mixed; boundary="===============3315047358196368494=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: [PATCH v2] ste: Use UTF-8 as a default character set
Date: Tue, 18 Jan 2011 17:45:44 +0200
Message-ID: <1295365544-21812-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3315047358196368494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ste.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 7bb7232..44cfc14 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -250,6 +250,10 @@ static int ste_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
 			NULL, NULL, NULL, NULL);
 =

+	/* All STE modems support UTF-8 */
+	g_at_chat_send(data->chat, "AT+CSCS=3D\"UTF-8\"", NULL, NULL, NULL,
+			NULL);
+
 	g_io_channel_unref(channel);
 	g_at_syntax_unref(syntax);
 =

-- =

1.7.0.4


--===============3315047358196368494==--

