Content-Type: multipart/mixed; boundary="===============4747668499858775180=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] huawei: use AT^SYSCFG for radio setting operations on 3G
 only modems
Date: Thu, 11 Jun 2020 11:12:26 +0200
Message-ID: <1591866746-5233-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4747668499858775180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AT^SYSCFGEX must be used on LTE Huawei modems to enable LTE support.
But some modems (or firmwares?) do not support this command and AT^SYSCFG
must be used to get/set radio settings.
This has been introduced in commit:
22adf6402c828f8b8cca1b65d8a46ba7792eb787

There is a bug in this commit and AT^SYSCFGEX commands are used even on
modems not supporting it.
---
 drivers/huaweimodem/radio-settings.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index 40431d3..20181d2 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -532,6 +532,7 @@ static void syscfgex_support_cb(gboolean ok, GAtResult =
*result,
 	if (!ok) {
 		g_at_chat_send(rsd->chat, "AT^SYSCFG=3D?", syscfg_prefix,
 					syscfg_support_cb, rs, NULL);
+		return;
 	}
 =

 	rsd->syscfgex_cap =3D 1;
-- =

2.7.4

--===============4747668499858775180==--

