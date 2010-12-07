Content-Type: multipart/mixed; boundary="===============4043311486712613574=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 5/7] phonesim: Move call forwarding to post sim
Date: Tue, 07 Dec 2010 12:37:45 -0800
Message-ID: <1291754267-26025-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1291754267-26025-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4043311486712613574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index c7ef0d7..b4795f2 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -635,6 +635,8 @@ static void phonesim_post_sim(struct ofono_modem *modem)
 	if (!data->calypso)
 		ofono_stk_create(modem, OFONO_VENDOR_PHONESIM,
 					"atmodem", data->chat);
+
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
 }
 =

 static void phonesim_post_online(struct ofono_modem *modem)
@@ -647,7 +649,6 @@ static void phonesim_post_online(struct ofono_modem *mo=
dem)
 	DBG("%p", modem);
 =

 	ofono_ussd_create(modem, 0, "atmodem", data->chat);
-	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
 	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
 =

 	if (data->calypso)
-- =

1.7.0.4


--===============4043311486712613574==--

