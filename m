Content-Type: multipart/mixed; boundary="===============7700210605954264742=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 1/4] ifxmodem: fix issue with gatchat usage
Date: Mon, 07 Feb 2011 13:07:35 -0800
Message-ID: <1297112858-12002-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1297112858-12002-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7700210605954264742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index f66815a..21e1944 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -720,8 +720,8 @@ static int ifx_voicecall_probe(struct ofono_voicecall *=
vc, unsigned int vendor,
 =

 	ofono_voicecall_set_data(vc, vd);
 =

-	g_at_chat_send(chat, "AT+XCALLSTAT=3D1", none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(chat, "AT+XEMC=3D1", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+XCALLSTAT=3D1", none_prefix, NULL, NULL, NUL=
L);
+	g_at_chat_send(vd->chat, "AT+XEMC=3D1", none_prefix, NULL, NULL, NULL);
 =

 	g_at_chat_send(vd->chat, "AT+CRC=3D1", none_prefix, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CLIP=3D1", none_prefix, NULL, NULL, NULL);
-- =

1.7.0.4


--===============7700210605954264742==--

