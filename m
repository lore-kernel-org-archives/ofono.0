Content-Type: multipart/mixed; boundary="===============1223318999494243072=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 4/5] hfpmodem: Add memory dialling support
Date: Mon, 12 Feb 2018 20:37:17 +0200
Message-ID: <20180212183718.17194-5-philippedeswert@gmail.com>
In-Reply-To: <20180212183718.17194-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1223318999494243072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe De Swert <philippedeswert@gmail.com>

Handle the request to dial from a memory index and send the
correct ATD> sequence to make it happen.
---
 drivers/hfpmodem/voicecall.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 1e0489c2..1254f235 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -422,6 +422,30 @@ static void hfp_dial_last(struct ofono_voicecall *vc, =
ofono_voicecall_cb_t cb,
 	CALLBACK_WITH_FAILURE(cb, data);
 =

 }
+
+static void hfp_dial_memory(struct ofono_voicecall *vc,
+			unsigned int memory_location, ofono_voicecall_cb_t cb,
+			void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[256];
+
+	cbd->user =3D vc;
+	DBG("Calling memory location %d\n", memory_location);
+	snprintf(buf, sizeof(buf), "ATD>%d", memory_location);
+
+	strcat(buf, ";");
+
+	if (g_at_chat_send(vd->chat, buf, none_prefix,
+				atd_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	DBG("at_chat_failed");
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static void hfp_template(const char *cmd, struct ofono_voicecall *vc,
 			GAtResultFunc result_cb, unsigned int affected_types,
 			ofono_voicecall_cb_t cb, void *data)
@@ -1287,6 +1311,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D hfp_voicecall_remove,
 	.dial			=3D hfp_dial,
 	.dial_last		=3D hfp_dial_last,
+	.dial_memory		=3D hfp_dial_memory,
 	.answer			=3D hfp_answer,
 	.hangup_active		=3D hfp_hangup,
 	.hold_all_active	=3D hfp_hold_all_active,
-- =

2.11.0


--===============1223318999494243072==--

