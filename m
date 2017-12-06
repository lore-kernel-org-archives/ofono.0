Content-Type: multipart/mixed; boundary="===============4402615755187096534=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 6/7] hfpmodem: Add memory dialling support
Date: Wed, 06 Dec 2017 17:36:03 +0200
Message-ID: <20171206153604.15080-7-philippedeswert@gmail.com>
In-Reply-To: <20171206153604.15080-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4402615755187096534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle the request to dial from a memory index and send the
correct ATD> sequence

---
 drivers/hfpmodem/voicecall.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index a32a3242..7d198af0 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -422,6 +422,31 @@ static void hfp_dial_last(struct ofono_voicecall *vc, =
enum ofono_clir_option cli
 	CALLBACK_WITH_FAILURE(cb, data);
 =

 }
+
+static void hfp_dial_memory(struct ofono_voicecall *vc,
+			long int memory_location,
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[256];
+
+	cbd->user =3D vc;
+	DBG("Calling memory location %ld\n", memory_location);
+	snprintf(buf, sizeof(buf), "ATD>%ld", memory_location);
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
@@ -1287,6 +1312,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D hfp_voicecall_remove,
 	.dial			=3D hfp_dial,
 	.dial_last		=3D hfp_dial_last,
+	.dial_memory		=3D hfp_dial_memory,
 	.answer			=3D hfp_answer,
 	.hangup_active		=3D hfp_hangup,
 	.hold_all_active	=3D hfp_hold_all_active,
-- =

2.11.0


--===============4402615755187096534==--

