Content-Type: multipart/mixed; boundary="===============5570334136519444293=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH] hfp_ag_bluez5: use none prefix for AT+BCC.
Date: Tue, 24 Mar 2015 15:20:40 +0100
Message-ID: <1427206840-5297-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5570334136519444293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

iPhone 5s with iOS8.2 sometimes failes to acknowledge AT+BCC
with OK. This means +CIEV events get consumed by this command
and call ended notification is not parsed.

Nov 30 00:00:19 ofonod[938]: > AT+BCC\r
Nov 30 00:00:28 ofonod[938]: < \r\n+CIEV: 2,0\r\n
---
 plugins/hfp_hf_bluez5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index f5c572d..4136630 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -390,7 +390,7 @@ static void hfp16_card_connect(struct ofono_handsfree_c=
ard *card,
 			info->ag_features & HFP_AG_FEATURE_CODEC_NEGOTIATION) {
 		struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-		g_at_chat_send(info->chat, "AT+BCC", NULL, bcc_cb, cbd, g_free);
+		g_at_chat_send(info->chat, "AT+BCC", none_prefix, bcc_cb, cbd, g_free);
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


--===============5570334136519444293==--

