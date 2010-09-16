Content-Type: multipart/mixed; boundary="===============5423054173138226875=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [n900-v5 4/5] modemconf: use isigen and n900
Date: Thu, 16 Sep 2010 17:56:18 +0300
Message-ID: <1284648979-19046-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284648979-19046-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5423054173138226875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Allow basic configuration of phonet links, too.
---
 plugins/modemconf.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index d7b1354..3a823e3 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -116,14 +116,17 @@ static int set_device(struct ofono_modem *modem,
 static int set_interface(struct ofono_modem *modem,
 					GKeyFile *keyfile, const char *group)
 {
-	char *iface;
+	char *value;
 =

-	iface =3D g_key_file_get_string(keyfile, group, "Interface", NULL);
-	if (!iface)
-		return -EINVAL;
+	value =3D g_key_file_get_string(keyfile, group, "Interface", NULL);
+	if (value)
+		ofono_modem_set_string(modem, "Interface", value);
+	g_free(value);
 =

-	ofono_modem_set_string(modem, "Interface", iface);
-	g_free(iface);
+	value =3D g_key_file_get_string(keyfile, group, "Address", NULL);
+	if (value)
+		ofono_modem_set_integer(modem, "Address", atoi(value));
+	g_free(value);
 =

 	return 0;
 }
@@ -141,8 +144,8 @@ static struct {
 	{ "ste",	set_interface	},
 	{ "calypso",	set_device	},
 	{ "palmpre",	set_device	},
-	{ "isimodem",	set_interface	},
-	{ "n900modem",	set_interface	},
+	{ "isigen",     set_interface   },
+	{ "n900",	set_interface	},
 	{ NULL }
 };
 =

-- =

1.7.0.4


--===============5423054173138226875==--

