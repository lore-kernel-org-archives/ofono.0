Content-Type: multipart/mixed; boundary="===============4577213568756902036=="
MIME-Version: 1.0
From: Krzysztof Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 4/5] hfp: Add CHLD features to drver data
Date: Mon, 17 Mar 2014 16:47:29 +0100
Message-ID: <1395071250-19440-5-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1395071250-19440-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4577213568756902036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Wilk <Krzysztofx.Wilk@intel.com>

---
 drivers/hfpmodem/handsfree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index 78ee801..bbe10b8 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -49,6 +49,7 @@ static const char *bvra_prefix[] =3D { "+BVRA:", NULL };
 struct hf_data {
 	GAtChat *chat;
 	unsigned int ag_features;
+	unsigned int ag_mpty_features;
 	int battchg_index;
 	guint register_source;
 };
@@ -139,6 +140,7 @@ static gboolean hfp_handsfree_register(gpointer user_da=
ta)
 		ofono_handsfree_set_inband_ringing(hf, TRUE);
 =

 	ofono_handsfree_set_ag_features(hf, hd->ag_features);
+	ofono_handsfree_set_ag_chld_features(hf, hd->ag_mpty_features);
 	ofono_handsfree_register(hf);
 =

 	return FALSE;
@@ -154,6 +156,7 @@ static int hfp_handsfree_probe(struct ofono_handsfree *=
hf,
 	hd =3D g_new0(struct hf_data, 1);
 	hd->chat =3D g_at_chat_clone(info->chat);
 	hd->ag_features =3D info->ag_features;
+	hd->ag_mpty_features =3D info->ag_mpty_features;
 =

 	ofono_handsfree_set_data(hf, hd);
 =

-- =

1.7.11.7

Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052


--===============4577213568756902036==--

