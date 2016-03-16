Content-Type: multipart/mixed; boundary="===============3867523546625285879=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] ril_sofia3gr: add ussd functionality invocation
Date: Wed, 16 Mar 2016 20:05:05 +0530
Message-ID: <1458138905-13614-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3867523546625285879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ril_sofia3gr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/ril_sofia3gr.c b/plugins/ril_sofia3gr.c
index 3f81fe9..eb27927 100644
--- a/plugins/ril_sofia3gr.c
+++ b/plugins/ril_sofia3gr.c
@@ -169,6 +169,7 @@ static void ril_post_online(struct ofono_modem *modem)
 =

 	ofono_netreg_create(modem, 0, "rilmodem", rd->ril);
 	ofono_radio_settings_create(modem, 0, "rilmodem", rd->ril);
+	ofono_ussd_create(modem, 0, "rilmodem", rd->ril);
 }
 =

 static void ril_set_online_cb(struct ril_msg *message, gpointer user_data)
-- =

1.9.1


--===============3867523546625285879==--

