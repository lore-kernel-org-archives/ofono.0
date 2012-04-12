Content-Type: multipart/mixed; boundary="===============7753242807108155187=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Huawei: core does not allow concurrent online and disable
 operations
Date: Thu, 12 Apr 2012 11:15:56 +0200
Message-ID: <1334222156-10301-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7753242807108155187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 5d8875a..f025be9 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -115,9 +115,12 @@ static void huawei_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 =

 	/* Cleanup after potential enable polling */
-	if (data->sysinfo_poll_source > 0)
+	if (data->sysinfo_poll_source > 0) {
 		g_source_remove(data->sysinfo_poll_source);
 =

+		g_free(data->online_cbd);
+	}
+
 	/* Cleanup after hot-unplug */
 	g_at_chat_unref(data->pcui);
 =

@@ -637,15 +640,6 @@ static int huawei_disable(struct ofono_modem *modem)
 	g_at_chat_cancel_all(data->pcui);
 	g_at_chat_unregister_all(data->pcui);
 =

-	/* Cleanup potential online enable polling */
-	if (data->sysinfo_poll_source > 0) {
-		g_source_remove(data->sysinfo_poll_source);
-		data->sysinfo_poll_source =3D 0;
-
-		g_free(data->online_cbd);
-		data->online_cbd =3D NULL;
-	}
-
 	g_at_chat_send(data->pcui, "AT+CFUN=3D0", none_prefix,
 					cfun_disable, modem, NULL);
 =

-- =

1.7.5.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============7753242807108155187==--

