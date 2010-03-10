Content-Type: multipart/mixed; boundary="===============7944878709550772539=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix Don't check CLIR CUG option in hfp_dial
Date: Wed, 10 Mar 2010 13:33:28 +0800
Message-ID: <1268199208-5318-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7944878709550772539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For HFP call, no need to check CLIR & CUG option. It doesn't affect dial
out string.
---
 drivers/hfpmodem/voicecall.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 1fa0eec..f83f26a 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -373,10 +373,6 @@ static void hfp_dial(struct ofono_voicecall *vc,
 	else
 		snprintf(buf, sizeof(buf), "ATD%s", ph->number);
 =

-	if ((clir !=3D OFONO_CLIR_OPTION_DEFAULT) ||
-			(cug !=3D OFONO_CUG_OPTION_DEFAULT))
-		goto error;
-
 	strcat(buf, ";");
 =

 	if (g_at_chat_send(vd->chat, buf, none_prefix,
-- =

1.6.6.1


--===============7944878709550772539==--

