Content-Type: multipart/mixed; boundary="===============7086925712325136897=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: [PATCH 7/8] hfpmodem: add dialing from memory index
Date: Tue, 31 Oct 2017 10:39:38 +0200
Message-ID: <20171031083939.4393-8-philippe.deswert@nomovok.com>
In-Reply-To: <20171031083939.4393-1-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7086925712325136897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle the request to dial from a memory index and send the
correct ATD> sequence
---
 drivers/hfpmodem/voicecall.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index fc5210bb..f40903c2 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -404,6 +404,28 @@ static void hfp_dial(struct ofono_voicecall *vc,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

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
+	snprintf(buf, sizeof(buf), "ATD>%ld", memory_location);
+
+	strcat(buf, ";");
+
+	if (g_at_chat_send(vd->chat, buf, none_prefix,
+				atd_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
 static void hfp_dial_last(struct ofono_voicecall *vc, ofono_voicecall_cb_t=
 cb,
 			void *data)
 {
@@ -1287,6 +1309,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.probe			=3D hfp_voicecall_probe,
 	.remove			=3D hfp_voicecall_remove,
 	.dial			=3D hfp_dial,
+	.dial_memory		=3D hfp_dial_memory,
 	.dial_last		=3D hfp_dial_last,
 	.answer			=3D hfp_answer,
 	.hangup_active		=3D hfp_hangup,
-- =

2.14.2


--===============7086925712325136897==--

