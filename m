Content-Type: multipart/mixed; boundary="===============5633768495349645270=="
MIME-Version: 1.0
From: Jimmy Gysens <jimmy.gysens_ext@softathome.com>
Subject: [PATCH] huawei: fix AT^SYSCFGEX acqorder "0201"
Date: Fri, 26 Jun 2020 08:36:40 +0200
Message-ID: <20200626063640.20182-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5633768495349645270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 6c574ee24a57d0397e4e3c617016bf026405960a ("huawei: the AT^SYSCFGEX
command supports additional modes") has a mistake for acqorder "0201". It
should be UMTS and GSM preferred.
---
 drivers/huaweimodem/radio-settings.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index ff7be48a..c8ebcba0 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -210,7 +210,7 @@ static void syscfgex_query_mode_cb(gboolean ok, GAtResu=
lt *result,
 	else if (strstr(acqorder, "0302"))
 		mode =3D (OFONO_RADIO_ACCESS_MODE_LTE | OFONO_RADIO_ACCESS_MODE_UMTS);
 	else if (strstr(acqorder, "0201"))
-		mode =3D (OFONO_RADIO_ACCESS_MODE_UMTS | OFONO_RADIO_ACCESS_MODE_LTE);
+		mode =3D (OFONO_RADIO_ACCESS_MODE_UMTS | OFONO_RADIO_ACCESS_MODE_GSM);
 	else if (strstr(acqorder, "03"))
 		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
 	else if (strstr(acqorder, "02"))
@@ -330,7 +330,7 @@ static void syscfgex_set_rat_mode(struct radio_settings=
_data *rsd,
 =

 	if (mode =3D=3D (OFONO_RADIO_ACCESS_MODE_LTE | OFONO_RADIO_ACCESS_MODE_UM=
TS))
 		acqorder =3D "0302";
-	else if (mode =3D=3D (OFONO_RADIO_ACCESS_MODE_UMTS | OFONO_RADIO_ACCESS_M=
ODE_LTE))
+	else if (mode =3D=3D (OFONO_RADIO_ACCESS_MODE_UMTS | OFONO_RADIO_ACCESS_M=
ODE_GSM))
 		acqorder =3D "0201";
 =

 	snprintf(buf, sizeof(buf), atcmd, acqorder);
-- =

2.17.1

--===============5633768495349645270==--

