Content-Type: multipart/mixed; boundary="===============2481831427474244315=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 2/6] Add IncomingStatusReport a{sv} signal.
Date: Fri, 04 Jun 2010 14:17:33 +0300
Message-ID: <1275650257-30593-3-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1275650257-30593-2-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2481831427474244315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index c0e9fc4..618e035 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -472,9 +472,10 @@ static GDBusMethodTable sms_manager_methods[] =3D {
 };
 =

 static GDBusSignalTable sms_manager_signals[] =3D {
-	{ "PropertyChanged",	"sv"		},
-	{ "IncomingMessage",	"sa{sv}"	},
-	{ "ImmediateMessage",	"sa{sv}"	},
+	{ "PropertyChanged",		"sv"		},
+	{ "IncomingMessage",		"sa{sv}"	},
+	{ "ImmediateMessage",		"sa{sv}"	},
+	{ "IncomingStatusReport",	"a{sv}"		},
 	{ }
 };
 =

-- =

1.6.0.4



--===============2481831427474244315==--

