Content-Type: multipart/mixed; boundary="===============8353995310070726160=="
MIME-Version: 1.0
From: anandx.ramakrishna@intel.com
Subject: [PATCH v1] ifx: Selftest at command syntax fix to support latest fw
Date: Tue, 08 Feb 2011 14:34:22 -0800
Message-ID: <1297204462-9766-1-git-send-email-anandx.ramakrishna@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8353995310070726160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Anand Ramakrishna <anandx.ramakrishna@intel.com>

It is a fix to support the selftest at command syntax changed in latest =

IFX fw version

---
 plugins/ifx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 2a95720..a41fc36 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -573,7 +573,7 @@ static void rtc_gti_selftest_cb(gboolean ok, GAtResult =
*result,
 	if (ok)
 		return;
 =

-	ofono_error("at(a)rtc:rtc_gti_test_verify_32khz()-FAILED");
+	ofono_error("at(a)rtc_drv:rtc_gti_test_verify_32khz()-FAILED");
 =

 	if (data->mux_init_timeout > 0) {
 		g_source_remove(data->mux_init_timeout);
@@ -643,7 +643,7 @@ static int ifx_enable(struct ofono_modem *modem)
 					NULL, NULL, NULL);
 =

 	/* Execute modem self tests */
-	g_at_chat_send(chat, "at(a)rtc:rtc_gti_test_verify_32khz()", NULL,
+	g_at_chat_send(chat, "at(a)rtc_drv:rtc_gti_test_verify_32khz()", NULL,
 					rtc_gti_selftest_cb, modem, NULL);
 =

 	g_at_chat_send(chat, "at(a)vers:device_version_id()", NULL,
-- =

1.7.2.3


--===============8353995310070726160==--

