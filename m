Content-Type: multipart/mixed; boundary="===============0104450923169562520=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 2/2] hfpmodem: slc.c: make sure to use none_prefix
Date: Tue, 24 Mar 2015 17:04:26 +0100
Message-ID: <1427213066-24974-2-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1427213066-24974-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0104450923169562520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/slc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 14e56af..8e62519 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -113,7 +113,8 @@ static void slc_established(struct slc_establish_data *=
sed)
 {
 	struct hfp_slc_info *info =3D sed->info;
 =

-	g_at_chat_send(info->chat, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(info->chat, "AT+CMEE=3D1", none_prefix,
+			NULL, NULL, NULL);
 	sed->connect_cb(sed->userdata);
 }
 =

@@ -434,8 +435,8 @@ static void brsf_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 			sprintf(str, "AT+BAC=3D%d", HFP_CODEC_CVSD);
 =

 		slc_establish_data_ref(sed);
-		g_at_chat_send(info->chat, str, NULL, bac_cb, sed,
-						slc_establish_data_unref);
+		g_at_chat_send(info->chat, str, none_prefix, bac_cb,
+				sed, slc_establish_data_unref);
 		return;
 	}
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


--===============0104450923169562520==--

