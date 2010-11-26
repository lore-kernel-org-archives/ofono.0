Content-Type: multipart/mixed; boundary="===============8349314632667513647=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 6/7] phonesim: Move call forwarding to post sim
Date: Thu, 25 Nov 2010 22:23:36 -0800
Message-ID: <1290752617-19024-7-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1290752617-19024-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8349314632667513647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d2faf42..e29d04d 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -470,6 +470,8 @@ static void phonesim_post_sim(struct ofono_modem *modem)
 	if (!data->calypso)
 		ofono_stk_create(modem, OFONO_VENDOR_PHONESIM,
 					"atmodem", data->chat);
+
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
 }
 =

 static void phonesim_post_online(struct ofono_modem *modem)
@@ -482,7 +484,6 @@ static void phonesim_post_online(struct ofono_modem *mo=
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


--===============8349314632667513647==--

