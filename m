Content-Type: multipart/mixed; boundary="===============4382276942414076125=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 4/4] udevng/xmm7xxx: Allow to detect xmm7xxx series modems
Date: Wed, 13 Sep 2017 07:58:44 +0530
Message-ID: <1505269724-19622-4-git-send-email-ankit.p.navik@intel.com>
In-Reply-To: <1505269724-19622-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4382276942414076125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Intel xmm7xxx series modem uses id as 8087:0930
---
 plugins/udevng.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 518eda8..787ee0f 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1121,6 +1121,42 @@ static gboolean setup_gemalto(struct modem_info* mod=
em)
 	return TRUE;
 }
 =

+static gboolean setup_xmm7xxx(struct modem_info *modem)
+{
+	const char *mdm =3D NULL, *net =3D NULL;
+	GSList *list;
+
+	DBG("%s %s\n", __DATE__, __TIME__);
+	DBG("%s %s %s %s %s %s\n", modem->syspath, modem->devname,
+		modem->driver, modem->vendor, modem->model, modem->sysattr);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s %s %s %s\n", info->devpath, info->devnode,
+				info->interface, info->number, info->label,
+				info->sysattr, info->subsystem);
+
+		if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
+			if (g_strcmp0(info->number, "02") =3D=3D 0)
+				mdm =3D info->devnode;
+		} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
+			if (g_strcmp0(info->number, "00") =3D=3D 0)
+				net =3D info->devnode;
+		}
+	}
+
+	if (mdm =3D=3D NULL || net =3D=3D NULL)
+		return FALSE;
+
+	DBG("modem=3D%s net=3D%s\n", mdm, net);
+
+	ofono_modem_set_string(modem->modem, "Modem", mdm);
+	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+
+	return TRUE;
+}
+
 static struct {
 	const char *name;
 	gboolean (*setup)(struct modem_info *modem);
@@ -1148,6 +1184,7 @@ static struct {
 	{ "quectelqmi",	setup_quectelqmi},
 	{ "ublox",	setup_ublox	},
 	{ "gemalto",	setup_gemalto	},
+	{ "xmm7xxx",	setup_xmm7xxx	},
 	/* Following are non-USB modems */
 	{ "ifx",	setup_ifx		},
 	{ "u8500",	setup_isi_serial	},
@@ -1524,6 +1561,8 @@ static struct {
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
 	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
+	{ "xmm7xxx",	"cdc_acm",	"8087", "0930"	},
+	{ "xmm7xxx",	"cdc_ncm",	"8087", "0930"	},
 	{ }
 };
 =

-- =

1.9.1


--===============4382276942414076125==--

