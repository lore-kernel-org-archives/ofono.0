Content-Type: multipart/mixed; boundary="===============0505700116160381644=="
MIME-Version: 1.0
From: Jimmy Gysens <jimmy.gysens_ext@softathome.com>
Subject: [PATCH] huawei: the AT^SYSCFGEX command supports additional modes
Date: Thu, 25 Jun 2020 11:29:42 +0200
Message-ID: <20200625092942.4736-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0505700116160381644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

- LTE and UMTS preferred (acqorder =3D 0302);
AT^SYSCFGEX=3D"0302",40000000,2,4,40000000

- UMTS and GSM preferred (acqorder =3D 0201);
AT^SYSCFGEX=3D"0201",40000000,2,4,40000000

For AT^SYSCFG, the modes are not available.
---
 drivers/huaweimodem/radio-settings.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index 20181d2b..ff7be48a 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -207,6 +207,10 @@ static void syscfgex_query_mode_cb(gboolean ok, GAtRes=
ult *result,
 				strstr(acqorder, "02") &&
 				strstr(acqorder, "03")))
 		mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+	else if (strstr(acqorder, "0302"))
+		mode =3D (OFONO_RADIO_ACCESS_MODE_LTE | OFONO_RADIO_ACCESS_MODE_UMTS);
+	else if (strstr(acqorder, "0201"))
+		mode =3D (OFONO_RADIO_ACCESS_MODE_UMTS | OFONO_RADIO_ACCESS_MODE_LTE);
 	else if (strstr(acqorder, "03"))
 		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
 	else if (strstr(acqorder, "02"))
@@ -281,6 +285,8 @@ static void syscfg_set_rat_mode(struct radio_settings_d=
ata *rsd,
 		break;
 	case OFONO_RADIO_ACCESS_MODE_LTE:
 		goto error;
+	default:
+		goto error;
 	}
 =

 	snprintf(buf, sizeof(buf), "AT^SYSCFG=3D%u,%u,40000000,2,4",
@@ -318,8 +324,15 @@ static void syscfgex_set_rat_mode(struct radio_setting=
s_data *rsd,
 	case OFONO_RADIO_ACCESS_MODE_LTE:
 		acqorder =3D "03";
 		break;
+	default:
+		break;
 	}
 =

+	if (mode =3D=3D (OFONO_RADIO_ACCESS_MODE_LTE | OFONO_RADIO_ACCESS_MODE_UM=
TS))
+		acqorder =3D "0302";
+	else if (mode =3D=3D (OFONO_RADIO_ACCESS_MODE_UMTS | OFONO_RADIO_ACCESS_M=
ODE_LTE))
+		acqorder =3D "0201";
+
 	snprintf(buf, sizeof(buf), atcmd, acqorder);
 =

 	if (g_at_chat_send(rsd->chat, buf, none_prefix,
-- =

2.17.1

--===============0505700116160381644==--

