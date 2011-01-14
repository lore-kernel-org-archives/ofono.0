Content-Type: multipart/mixed; boundary="===============6223329778556442719=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: [PATCH 2/2] ste: Enable vendor quirk for USSD
Date: Fri, 14 Jan 2011 16:12:51 +0200
Message-ID: <1295014371-9148-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6223329778556442719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This USSD quirk won't work for MT USSD

---
 plugins/ste.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 7bb7232..3ede210 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -363,7 +363,7 @@ static void ste_post_online(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_ussd_create(modem, 0, "atmodem", data->chat);
+	ofono_ussd_create(modem, OFONO_VENDOR_STE, "atmodem", data->chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
 	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
 	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem", data->chat);
-- =

1.7.0.4


--===============6223329778556442719==--

