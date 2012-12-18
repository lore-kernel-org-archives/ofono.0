Content-Type: multipart/mixed; boundary="===============2596736631544640382=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] udevng: support telit modems using cdc-acm driver
Date: Tue, 18 Dec 2012 09:32:39 +0100
Message-ID: <1355819559-7956-1-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <50CF3CB1.9070401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2596736631544640382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for Telit modem using the cdc-acm driver, like the Telit
HE910.
---
 plugins/udevng.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index afb02ca..16515e3 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -619,6 +619,13 @@ static gboolean setup_telit(struct modem_info *modem)
 				gps =3D info->devnode;
 			else if (g_strcmp0(info->number, "03") =3D=3D 0)
 				aux =3D info->devnode;
+		} else if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
+			if (g_strcmp0(info->number, "00") =3D=3D 0)
+				mdm =3D info->devnode;
+			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+				diag =3D info->devnode;
+			else if (g_strcmp0(info->number, "06") =3D=3D 0)
+				aux =3D info->devnode;
 		}
 	}
 =

@@ -630,6 +637,7 @@ static gboolean setup_telit(struct modem_info *modem)
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "Aux", aux);
 	ofono_modem_set_string(modem->modem, "GPS", gps);
+	ofono_modem_set_string(modem->modem, "Diag", diag);
 =

 	return TRUE;
 }
@@ -777,7 +785,7 @@ static struct {
 	{ "alcatel",	setup_alcatel	},
 	{ "novatel",	setup_novatel	},
 	{ "nokia",	setup_nokia	},
-	{ "telit",	setup_telit	},
+	{ "telit",	setup_telit,	"device/interface"	},
 	{ "simcom",	setup_simcom	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
@@ -987,6 +995,7 @@ static struct {
 	{ "zte",	"option",	"19d2"		},
 	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "telit",	"usbserial",	"1bc7"		},
+	{ "telit",	"cdc_acm",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============2596736631544640382==--

