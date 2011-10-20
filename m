Content-Type: multipart/mixed; boundary="===============0441021229172171299=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 11/15] hfpmodem: Avoid segfault in call-volume
Date: Thu, 20 Oct 2011 18:38:16 +0200
Message-ID: <1319128700-15841-12-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319128700-15841-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0441021229172171299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The use of g_idle_add can cause a segmentation fault if the object is
destroyed in the meantime.
---
 drivers/hfpmodem/call-volume.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/hfpmodem/call-volume.c b/drivers/hfpmodem/call-volume.c
index 804d9e2..e91d34b 100644
--- a/drivers/hfpmodem/call-volume.c
+++ b/drivers/hfpmodem/call-volume.c
@@ -50,6 +50,7 @@ struct cv_data {
 	GAtChat *chat;
 	unsigned char sp_volume;
 	unsigned char mic_volume;
+	guint registration_event_id;
 };
 =

 static void cv_generic_set_cb(gboolean ok, GAtResult *result,
@@ -173,6 +174,8 @@ static gboolean hfp_call_volume_register(gpointer user_=
data)
 =

 	DBG("");
 =

+	vd->registration_event_id =3D 0;
+
 	g_at_chat_register(vd->chat, "+VGS:", vgs_notify, FALSE, cv, NULL);
 	g_at_chat_register(vd->chat, "+VGM:", vgm_notify, FALSE, cv, NULL);
 =

@@ -197,7 +200,7 @@ static int hfp_call_volume_probe(struct ofono_call_volu=
me *cv,
 =

 	ofono_call_volume_set_data(cv, vd);
 =

-	g_idle_add(hfp_call_volume_register, cv);
+	vd->registration_event_id =3D g_idle_add(hfp_call_volume_register, cv);
 =

 	return 0;
 }
@@ -206,6 +209,9 @@ static void hfp_call_volume_remove(struct ofono_call_vo=
lume *cv)
 {
 	struct cv_data *vd =3D ofono_call_volume_get_data(cv);
 =

+	if (vd->registration_event_id !=3D 0)
+		g_source_remove(vd->registration_event_id);
+
 	ofono_call_volume_set_data(cv, NULL);
 =

 	g_at_chat_unref(vd->chat);
-- =

1.7.6.4


--===============0441021229172171299==--

