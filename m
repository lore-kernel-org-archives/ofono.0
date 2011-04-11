Content-Type: multipart/mixed; boundary="===============8785366956479812576=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 11/20] modem: generalise feature map table
Date: Mon, 11 Apr 2011 13:20:09 +0300
Message-ID: <1302517218-2147-12-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8785366956479812576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only change is "gprs" to "packet".
---
 src/modem.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index bb0374a..aecb35a 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1260,16 +1260,16 @@ static const struct {
 	const char *interface;
 	const char *feature;
 } feature_map[] =3D {
-	{ OFONO_NETWORK_REGISTRATION_INTERFACE,		"net"	},
-	{ OFONO_RADIO_SETTINGS_INTERFACE,		"rat"	},
-	{ OFONO_CELL_BROADCAST_INTERFACE,		"cbs"	},
-	{ OFONO_MESSAGE_MANAGER_INTERFACE,		"sms"	},
-	{ OFONO_SIM_MANAGER_INTERFACE,			"sim"	},
-	{ OFONO_STK_INTERFACE,				"stk"	},
-	{ OFONO_SUPPLEMENTARY_SERVICES_INTERFACE,	"ussd"	},
-	{ OFONO_CONNECTION_MANAGER_INTERFACE,		"gprs"	},
-	{ OFONO_TEXT_TELEPHONY_INTERFACE,		"tty"	},
-	{ OFONO_LOCATION_REPORTING_INTERFACE,		"gps"	},
+	{ OFONO_NETWORK_REGISTRATION_INTERFACE,		"net"		},
+	{ OFONO_RADIO_SETTINGS_INTERFACE,		"rat"		},
+	{ OFONO_CELL_BROADCAST_INTERFACE,		"cbs"		},
+	{ OFONO_MESSAGE_MANAGER_INTERFACE,		"sms"		},
+	{ OFONO_SIM_MANAGER_INTERFACE,			"sim"		},
+	{ OFONO_STK_INTERFACE,				"stk"		},
+	{ OFONO_SUPPLEMENTARY_SERVICES_INTERFACE,	"ussd"		},
+	{ OFONO_CONNECTION_MANAGER_INTERFACE,		"packet"	},
+	{ OFONO_TEXT_TELEPHONY_INTERFACE,		"tty"		},
+	{ OFONO_LOCATION_REPORTING_INTERFACE,		"gps"		},
 	{ },
 };
 =

-- =

1.7.0.4


--===============8785366956479812576==--

