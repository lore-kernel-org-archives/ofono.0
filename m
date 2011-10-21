Content-Type: multipart/mixed; boundary="===============6197780731884152883=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 09/12] hfpmodem: Avoid segfault in handsfree
Date: Fri, 21 Oct 2011 18:51:34 +0200
Message-ID: <1319215897-6310-10-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319215897-6310-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6197780731884152883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The use of g_idle_add can cause a segmentation fault if the object is
destroyed in the meantime.
---
 drivers/hfpmodem/handsfree.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index 984708d..abe2ad2 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -48,6 +48,7 @@ static const char *bvra_prefix[] =3D { "+BVRA:", NULL };
 struct hf_data {
 	GAtChat *chat;
 	unsigned int ag_features;
+	guint register_source;
 };
 =

 static void hf_generic_set_cb(gboolean ok, GAtResult *result,
@@ -101,6 +102,8 @@ static gboolean hfp_handsfree_register(gpointer user_da=
ta)
 	struct ofono_handsfree *hf =3D user_data;
 	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
 =

+	hd->register_source =3D 0;
+
 	g_at_chat_register(hd->chat, "+BSIR:", bsir_notify, FALSE, hf, NULL);
 	g_at_chat_register(hd->chat, "+BVRA:", bvra_notify, FALSE, hf, NULL);
 =

@@ -126,7 +129,7 @@ static int hfp_handsfree_probe(struct ofono_handsfree *=
hf,
 =

 	ofono_handsfree_set_data(hf, hd);
 =

-	g_idle_add(hfp_handsfree_register, hf);
+	hd->register_source =3D g_idle_add(hfp_handsfree_register, hf);
 =

 	return 0;
 }
@@ -135,6 +138,9 @@ static void hfp_handsfree_remove(struct ofono_handsfree=
 *hf)
 {
 	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
 =

+	if (hd->register_source !=3D 0)
+		g_source_remove(hd->register_source);
+
 	ofono_handsfree_set_data(hf, NULL);
 =

 	g_at_chat_unref(hd->chat);
-- =

1.7.6.4


--===============6197780731884152883==--

