Content-Type: multipart/mixed; boundary="===============0341645002471495144=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/6] phonesim: Don't use VENDOR_PHONESIM for Calypso.
Date: Thu, 05 Aug 2010 19:30:52 +0200
Message-ID: <1281029457-9048-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0341645002471495144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also move the STK initialisation to post-sim because it is more logical
there (even if it makes no difference under phonesim).

I'm not sure if there's any user of the "calypso" mode in phonesim
driver now, perhaps it can be removed.
---
 plugins/phonesim.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 9c5b2cb..97fa530 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -289,8 +289,6 @@ static void phonesim_pre_sim(struct ofono_modem *modem)
 	else
 		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 =

-	ofono_stk_create(modem, OFONO_VENDOR_PHONESIM, "atmodem", data->chat);
-
 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
@@ -304,6 +302,10 @@ static void phonesim_post_sim(struct ofono_modem *mode=
m)
 =

 	DBG("%p", modem);
 =

+	if (!data->calypso)
+		ofono_stk_create(modem, OFONO_VENDOR_PHONESIM,
+					"atmodem", data->chat);
+
 	ofono_ussd_create(modem, 0, "atmodem", data->chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
 	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
-- =

1.7.1.86.g0e460.dirty


--===============0341645002471495144==--

