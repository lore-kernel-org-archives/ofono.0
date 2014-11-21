Content-Type: multipart/mixed; boundary="===============6781499763601102652=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: [PATCH 1/2] sms: Option HSO modem can't really do CNMA
Date: Fri, 21 Nov 2014 01:48:25 +0000
Message-ID: <1416534506-19999-1-git-send-email-neil@ossau.homelinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6781499763601102652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It appears the Option HSO modem can't really do CNMA, so ignore the
fact that it returns 1 for the 'service' value in its response to
AT+CSMS?
---
 drivers/atmodem/sms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index f93dd23..2eab58e 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -1178,6 +1178,7 @@ static void at_csms_status_cb(gboolean ok, GAtResult =
*result,
 		switch (data->vendor) {
 		case OFONO_VENDOR_HUAWEI:
 		case OFONO_VENDOR_NOVATEL:
+		case OFONO_VENDOR_OPTION_HSO:
 			g_at_result_iter_skip_next(&iter);
 			service =3D 0;
 			break;
-- =

2.1.1


--===============6781499763601102652==--

