Content-Type: multipart/mixed; boundary="===============5295691041567575741=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 1/2] hfpmodem: hfpmodem.c make sure to use none_prefix
Date: Tue, 24 Mar 2015 17:04:25 +0100
Message-ID: <1427213066-24974-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5295691041567575741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/handsfree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index d5162f2..6e8c4d3 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -45,6 +45,7 @@
 =

 static const char *binp_prefix[] =3D { "+BINP:", NULL };
 static const char *bvra_prefix[] =3D { "+BVRA:", NULL };
+static const char *none_prefix[] =3D { NULL };
 =

 struct hf_data {
 	GAtChat *chat;
@@ -197,7 +198,7 @@ static void hfp_cnum_query(struct ofono_handsfree *hf,
 	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (g_at_chat_send(hd->chat, "AT+CNUM", NULL,
+	if (g_at_chat_send(hd->chat, "AT+CNUM", none_prefix,
 					cnum_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -382,8 +383,8 @@ static void hfp_disable_nrec(struct ofono_handsfree *hf,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	const char *buf =3D "AT+NREC=3D0";
 =

-	if (g_at_chat_send(hd->chat, buf, NULL, hf_generic_set_cb,
-							cbd, g_free) > 0)
+	if (g_at_chat_send(hd->chat, buf, none_prefix,
+				hf_generic_set_cb, cbd, g_free) > 0)
 		return;
 =

 	g_free(cbd);
@@ -401,8 +402,8 @@ static void hfp_hf_indicator(struct ofono_handsfree *hf,
 =

 	snprintf(buf, sizeof(buf), "AT+BIEV=3D%u,%u", indicator, value);
 =

-	if (g_at_chat_send(hd->chat, buf, NULL, hf_generic_set_cb,
-							cbd, g_free) > 0)
+	if (g_at_chat_send(hd->chat, buf, none_prefix,
+				hf_generic_set_cb, cbd, g_free) > 0)
 		return;
 =

 	g_free(cbd);
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


--===============5295691041567575741==--

