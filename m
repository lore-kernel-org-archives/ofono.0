Content-Type: multipart/mixed; boundary="===============8875642885173213378=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/7] ifx: Move call forwarding to post sim
Date: Mon, 29 Nov 2010 02:37:58 -0800
Message-ID: <1291027083-19231-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1291027083-19231-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8875642885173213378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ifx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 037273a..cd6e667 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -703,6 +703,7 @@ static void ifx_post_sim(struct ofono_modem *modem)
 	ofono_stk_create(modem, 0, "ifxmodem", data->dlcs[AUX_DLC]);
 	ofono_phonebook_create(modem, OFONO_VENDOR_IFX,
 					"atmodem", data->dlcs[AUX_DLC]);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 }
 =

 static void ifx_post_online(struct ofono_modem *modem)
@@ -724,7 +725,6 @@ static void ifx_post_online(struct ofono_modem *modem)
 	ofono_ussd_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 =

 	ofono_ssn_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
-	ofono_call_forwarding_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_settings_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_meter_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_barring_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
-- =

1.7.0.4


--===============8875642885173213378==--

