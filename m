Content-Type: multipart/mixed; boundary="===============7879208460054238050=="
MIME-Version: 1.0
From: Bob Ham <bob.ham@puri.sm>
Subject: [PATCH 1/2] atmodem: Don't set AT+COLP=1 on SIMCom modems
Date: Mon, 14 May 2018 14:42:28 +0100
Message-ID: <20180514134229.14050-2-bob.ham@puri.sm>
In-Reply-To: <20180514134229.14050-1-bob.ham@puri.sm>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7879208460054238050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On the SIMCom SIM7100E, setting AT+COLP=3D1 causes there to be no
response at all from "ATD...;" commands until the call is answered.
The results in oFono stalling rather than creating a new VoiceCall
object.

We fix this by adding SIMCOM to the list of vendors for whom we set
AT+COLP=3D0 rather than AT+COLP=3D1.
---
 drivers/atmodem/voicecall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index e4c59c26..aa56f1ee 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -1120,6 +1120,7 @@ static int at_voicecall_probe(struct ofono_voicecall =
*vc, unsigned int vendor,
 =

 	switch (vd->vendor) {
 	case OFONO_VENDOR_QUALCOMM_MSM:
+	case OFONO_VENDOR_SIMCOM:
 		g_at_chat_send(vd->chat, "AT+COLP=3D0", NULL, NULL, NULL, NULL);
 		break;
 	default:
-- =

2.11.0


--===============7879208460054238050==--

