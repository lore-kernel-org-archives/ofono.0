Content-Type: multipart/mixed; boundary="===============5869816887110203157=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] plugins/ril: enable cbs
Date: Wed, 18 May 2016 10:46:59 +0800
Message-ID: <1463539619-29272-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5869816887110203157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

---
 plugins/ril.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/ril.c b/plugins/ril.c
index 2ea3fb5..a98646c 100644
--- a/plugins/ril.c
+++ b/plugins/ril.c
@@ -239,6 +239,7 @@ void ril_post_online(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 =

+	ofono_cbs_create(modem, rd->vendor, RILMODEM, rd->ril);
 	ofono_netreg_create(modem, rd->vendor, RILMODEM, rd->ril);
 	ofono_ussd_create(modem, rd->vendor, RILMODEM, rd->ril);
 	ofono_call_settings_create(modem, rd->vendor, RILMODEM, rd->ril);
-- =

2.7.4


--===============5869816887110203157==--

