Content-Type: multipart/mixed; boundary="===============0339144730747150639=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/9] calypsomodem: use ofono_call initializer
Date: Tue, 01 Feb 2011 15:12:45 -0200
Message-ID: <1296580370-2823-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296580370-2823-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0339144730747150639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/calypsomodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/calypsomodem/voicecall.c b/drivers/calypsomodem/voicec=
all.c
index 01be990..fed442c 100644
--- a/drivers/calypsomodem/voicecall.c
+++ b/drivers/calypsomodem/voicecall.c
@@ -314,7 +314,7 @@ static void cpi_notify(GAtResult *result, gpointer user=
_data)
 		g_at_chat_send(vd->chat, "AT%N0187", none_prefix,
 				NULL, NULL, NULL);
 =

-	memset(&call, 0, sizeof(call));
+	ofono_call_init(&call);
 =

 	switch (msgtype) {
 	case 0:
-- =

1.7.4


--===============0339144730747150639==--

