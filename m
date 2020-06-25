Content-Type: multipart/mixed; boundary="===============7505177745767279551=="
MIME-Version: 1.0
From: Jimmy Gysens <jimmy.gysens_ext@softathome.com>
Subject: [PATCH] huawei: send restore settings command on startup
Date: Thu, 25 Jun 2020 11:29:54 +0200
Message-ID: <20200625092954.4785-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7505177745767279551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When initializing a Huawei device, send the AT&F0 command to restore the
default AT settings on device restart.

Huawei stores all APN settings, which can cause issues when changing the
APN. The AT&F0 command makes sure the device starts from a clean state.
---
 plugins/huawei.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 35195e2d..681e643f 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -419,6 +419,10 @@ static void sysinfo_enable_cb(gboolean ok, GAtResult *=
result,
 	g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
 	g_at_chat_send(data->pcui, "AT&C0", NULL, NULL, NULL, NULL);
 =

+	/* Restore settings after restart */
+	g_at_chat_send(data->modem, "AT&F0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->pcui, "AT&F0", NULL, NULL, NULL, NULL);
+
 	/*
 	 * Ensure that the modem is using GSM character set and not IRA,
 	 * otherwise weirdness with umlauts and other non-ASCII characters
-- =

2.17.1

--===============7505177745767279551==--

