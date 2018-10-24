Content-Type: multipart/mixed; boundary="===============1906774084701974555=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/2] src/modem - timeout_hint
Date: Wed, 24 Oct 2018 07:28:10 +0200
Message-ID: <20181024052810.28128-2-gciofono@gmail.com>
In-Reply-To: <20181024052810.28128-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1906774084701974555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

this patch provides the handling for the modem-depending powered timeout

It provides the trivial implementation for
ofono_modem_set_powered_timeout_hint, introducing the ofono_modem
variable timeout_hint, used together with the existing ofono_modem
variable timeout.

The default value, previously hardcoded as a magic number, is provided
by the DEFAULT__POWERED_TIMEOUT define and set as soon as the
ofono_modem struct is created, and then can be overwritten by the
aforementioned ofono_modem_set_powered_timeout_hint.
---
 src/modem.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 9e254482..49e306ac 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -34,6 +34,8 @@
 =

 #include "common.h"
 =

+#define DEFAULT__POWERED_TIMEOUT (20)
+
 static GSList *g_devinfo_drivers =3D NULL;
 static GSList *g_driver_list =3D NULL;
 static GSList *g_modem_list =3D NULL;
@@ -75,6 +77,7 @@ struct ofono_modem {
 	char			*lock_owner;
 	guint			lock_watch;
 	guint			timeout;
+	guint			timeout_hint;
 	ofono_bool_t		online;
 	struct ofono_watchlist	*online_watches;
 	struct ofono_watchlist	*powered_watches;
@@ -1055,7 +1058,7 @@ static DBusMessage *set_property_lockdown(struct ofon=
o_modem *modem,
 		}
 =

 		modem->pending =3D dbus_message_ref(msg);
-		modem->timeout =3D g_timeout_add_seconds(20,
+		modem->timeout =3D g_timeout_add_seconds(modem->timeout_hint,
 						set_powered_timeout, modem);
 		return NULL;
 	}
@@ -1133,7 +1136,8 @@ static DBusMessage *modem_set_property(DBusConnection=
 *conn,
 				return __ofono_error_failed(msg);
 =

 			modem->pending =3D dbus_message_ref(msg);
-			modem->timeout =3D g_timeout_add_seconds(20,
+			modem->timeout =3D g_timeout_add_seconds(
+						modem->timeout_hint,
 						set_powered_timeout, modem);
 			return NULL;
 		}
@@ -1843,6 +1847,13 @@ ofono_bool_t ofono_modem_get_boolean(struct ofono_mo=
dem *modem, const char *key)
 	return value;
 }
 =

+void ofono_modem_set_powered_timeout_hint(struct ofono_modem *modem,
+							unsigned int seconds)
+{
+	modem->timeout_hint =3D seconds;
+}
+
+
 void ofono_modem_set_name(struct ofono_modem *modem, const char *name)
 {
 	if (modem->name)
@@ -1904,6 +1915,7 @@ struct ofono_modem *ofono_modem_create(const char *na=
me, const char *type)
 	modem->driver_type =3D g_strdup(type);
 	modem->properties =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, unregister_property);
+	modem->timeout_hint =3D DEFAULT__POWERED_TIMEOUT;
 =

 	g_modem_list =3D g_slist_prepend(g_modem_list, modem);
 =

-- =

2.17.1


--===============1906774084701974555==--

