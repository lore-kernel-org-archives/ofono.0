Content-Type: multipart/mixed; boundary="===============9209664659147260701=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 14/28] gobi: label interfaces via udev rules
Date: Thu, 30 Mar 2017 22:52:55 +0200
Message-ID: <20170330205309.25850-15-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9209664659147260701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules | 24 ++++++++++++++++++++++++
 plugins/udevng.c    | 28 ++++++++++++++--------------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index fe673cd..4d70735 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -36,4 +36,28 @@ DRIVER=3D=3D"cdc_phonet",ENV{OFONO_DRIVER}=3D"isiusb"
 ENV{OFONO_DRIVER}=3D=3D"isiusb",ATTR{type}=3D=3D"820",ENV{OFONO_LABEL}=3D"=
modem"
 ENV{OFONO_LABEL}=3D=3D"modem",ENV{INTERFACE}=3D=3D"2/254/0",ENV{OFONO_LABE=
L}=3D"modem16"
 =

+# If OFONO_DRIVER is set now, we are done.  If not, we make an additional
+# effort to find an appropriate driver and labelling.
+ENV{OFONO_DRIVER}=3D"?*",GOTO=3D"ofono_end"
+
+# If no product rule matched the interface then we still have an option:
+# the kernel also has device tables that it uses to attach drivers to
+# devices.  If the interface has an attached driver, then we can use
+# this information to attempt to label it.
+
+DRIVER=3D=3D"qmi_wwan",ENV{OFONO_DRIVER}=3D"gobi",ENV{OFONO_LABEL}=3D"qmi"
+
+# Product rules are preferred for everything except "qmi" interfaces
+# in order to keep the below rules as minimal as possible.  The below
+# should be considered only as a fallback.
+
+DRIVER=3D=3D"qcserial",ENV{OFONO_DRIVER}=3D"gobi"
+ENV{OFONO_DRIVER}!=3D"gobi",GOTO=3D"gobi_end"
+ENV{INTERFACE}!=3D"255/255/255",GOTO=3D"gobi_end"
+ATTR{bInterfaceNumber}=3D=3D"00",ENV{OFONO_LABEL}=3D"net"
+ATTR{bInterfaceNumber}=3D=3D"01",ENV{OFONO_LABEL}=3D"diag"
+ATTR{bInterfaceNumber}=3D=3D"02",ENV{OFONO_LABEL}=3D"modem"
+ATTR{bInterfaceNumber}=3D=3D"03",ENV{OFONO_LABEL}=3D"gps"
+LABEL=3D"gobi_end"
+
 LABEL=3D"ofono_end"
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 508db04..c19dc1c 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -204,18 +204,19 @@ static gboolean setup_gobi(struct modem_info *modem)
 		DBG("%s %s %s %s", info->devnode, info->interface,
 						info->number, info->label);
 =

-		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (info->number =3D=3D NULL)
-				qmi =3D info->devnode;
-			else if (g_strcmp0(info->number, "00") =3D=3D 0)
-				net =3D info->devnode;
-			else if (g_strcmp0(info->number, "01") =3D=3D 0)
-				diag =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				gps =3D info->devnode;
-		}
+		if (g_strcmp0(info->label, "qmi") =3D=3D 0)
+			/* FIXME: subsystem detection to separate 'qmi' and
+			 * 'net' atoms???
+			 */
+			qmi =3D info->devnode;
+		else if (g_strcmp0(info->label, "net") =3D=3D 0)
+			net =3D info->devnode;
+		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
+			mdm =3D info->devnode;
+		else if (g_strcmp0(info->label, "diag") =3D=3D 0)
+			diag =3D info->devnode;
+		else if (g_strcmp0(info->label, "gps") =3D=3D 0)
+			gps =3D info->devnode;
 	}
 =

 	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
@@ -223,6 +224,7 @@ static gboolean setup_gobi(struct modem_info *modem)
 =

 	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
 =

+	/* FIXME: gps node not used... */
 	ofono_modem_set_string(modem->modem, "Device", qmi);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "Diag", diag);
@@ -1337,8 +1339,6 @@ static struct {
 	{ "mbm",	"cdc_acm",	"0930"		},
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
-	{ "gobi",	"qmi_wwan"			},
-	{ "gobi",	"qcserial"			},
 	{ "sierra",	"qmi_wwan",	"1199"		},
 	{ "sierra",	"qcserial",	"1199"		},
 	{ "sierra",	"sierra"			},
-- =

2.9.3


--===============9209664659147260701==--

