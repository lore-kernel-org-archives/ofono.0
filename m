Content-Type: multipart/mixed; boundary="===============6456587303560596479=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 2/3] modem: Add SystemPath dbus property
Date: Mon, 19 Feb 2018 15:57:13 +0100
Message-ID: <1519052234-13973-3-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1519052234-13973-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6456587303560596479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/modem.c b/src/modem.c
index d5fda7c..0cee861 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -792,6 +792,7 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	struct ofono_devinfo *info;
 	dbus_bool_t emergency =3D ofono_modem_get_emergency_mode(modem);
 	const char *strtype;
+	const char *system_path;
 =

 	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
 				&modem->online);
@@ -832,6 +833,11 @@ void __ofono_modem_append_properties(struct ofono_mode=
m *modem,
 						&info->svn);
 	}
 =

+	system_path =3D ofono_modem_get_string(modem, "SystemPath");
+	if (system_path)
+		ofono_dbus_dict_append(dict, "SystemPath", DBUS_TYPE_STRING,
+					&system_path);
+
 	interfaces =3D g_new0(char *, g_slist_length(modem->interface_list) + 1);
 	for (i =3D 0, l =3D modem->interface_list; l; l =3D l->next, i++)
 		interfaces[i] =3D l->data;
-- =

2.7.4


--===============6456587303560596479==--

