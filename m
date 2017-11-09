Content-Type: multipart/mixed; boundary="===============7204432432683441803=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 3/3] plugins: updated plugins using simauth module
Date: Thu, 09 Nov 2017 09:52:17 -0800
Message-ID: <1510249937-22427-3-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1510249937-22427-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7204432432683441803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The simauth creation API changed to not take the driver structure
---
 plugins/mbm.c      | 2 +-
 plugins/phonesim.c | 2 +-
 plugins/xmm7xxx.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index fa0088c..b787aeb 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -452,7 +452,7 @@ static void mbm_post_sim(struct ofono_modem *modem)
 	ofono_radio_settings_create(modem, 0, "stemodem", data->modem_port);
 =

 	ofono_sms_create(modem, 0, "atmodem", data->modem_port);
-	ofono_sim_auth_create(modem, 0, "atmodem", data->modem_port);
+	ofono_sim_auth_create(modem);
 }
 =

 static void mbm_post_online(struct ofono_modem *modem)
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 3af2c46..bbbcbb3 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -861,7 +861,7 @@ static void phonesim_post_sim(struct ofono_modem *modem)
 		ofono_sms_create(modem, 0, "atmodem", data->chat);
 =

 	ofono_radio_settings_create(modem, 0, "phonesim", data->chat);
-	ofono_sim_auth_create(modem, 0, "atmodem", data->chat);
+	ofono_sim_auth_create(modem);
 }
 =

 static void phonesim_post_online(struct ofono_modem *modem)
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index a2582df..9f0ae8f 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -325,7 +325,7 @@ static void xmm7xxx_post_sim(struct ofono_modem *modem)
 =

 	ofono_lte_create(modem, "atmodem", data->chat);
 	ofono_radio_settings_create(modem, 0, "xmm7modem", data->chat);
-	ofono_sim_auth_create(modem, 0, "atmodem", data->chat);
+	ofono_sim_auth_create(modem);
 }
 =

 static void xmm7xxx_post_online(struct ofono_modem *modem)
-- =

2.7.4


--===============7204432432683441803==--

