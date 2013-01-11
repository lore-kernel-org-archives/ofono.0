Content-Type: multipart/mixed; boundary="===============1843988380806749945=="
MIME-Version: 1.0
From: mail@timomueller.eu
Subject: [PATCH] hfpmodem: Delay AT+CLCC request after outgoing callsetup
Date: Fri, 11 Jan 2013 14:00:32 +0100
Message-ID: <c97f1d8ae1e614a832b53b2b0c6f5da33c710a97.1357896034.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1357896034.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1843988380806749945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

Currently the list of current calls is requested right after an
outgoing callsetup has been reported by the AG device. If the AG
device updates the list after reporting the callsetup the +CLCC
response may not contain the new call and it is not registered
with oFono.

AT sequence that exhibited the failure (AG device was a Nokia N9
placing an outgoing call)

< \r\n+CIEV: 5,2\r\n
> AT+CLCC\r
< \r\nOK\r\n
< \r\n+VGS=3D7\r\n
< \r\n+VGM=3D7\r\n
< \r\n+CIEV: 5,3\r\n
< \r\n+CIEV: 4,1\r\n
< \r\n+CIEV: 5,0\r\n
---
 drivers/hfpmodem/voicecall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 505601c..c7c5f45 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -912,8 +912,11 @@ static void ciev_callsetup_notify(struct ofono_voiceca=
ll *vc,
 		 * from HF: query and sync the phone number.
 		 * from AG: query and create call.
 		 */
-		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				clcc_poll_cb, vc, NULL);
+		if (vd->clcc_source)
+			g_source_remove(vd->clcc_source);
+
+		vd->clcc_source =3D g_timeout_add(POLL_CLCC_DELAY,
+							poll_clcc, vc);
 		break;
 =

 	case 3:
-- =

1.7.11.7


--===============1843988380806749945==--

