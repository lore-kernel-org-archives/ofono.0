Content-Type: multipart/mixed; boundary="===============3658576591567237034=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC PATCH 4/9] modem: add Emergency property
Date: Thu, 31 Mar 2011 09:18:27 -0700
Message-ID: <1301588312-6932-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3658576591567237034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 2b49770..0aef463 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -669,6 +669,7 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	int i;
 	GSList *l;
 	struct ofono_atom *devinfo_atom;
+	dbus_bool_t emergency =3D ofono_modem_get_emergency_mode(modem);
 =

 	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
 				&modem->online);
@@ -679,6 +680,9 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	ofono_dbus_dict_append(dict, "Lockdown", DBUS_TYPE_BOOLEAN,
 				&modem->lockdown);
 =

+	ofono_dbus_dict_append(dict, "Emergency", DBUS_TYPE_BOOLEAN,
+				&emergency);
+
 	devinfo_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_DEVINFO);
 =

 	/* We cheat a little here and don't check the registered status */
-- =

1.7.0.4


--===============3658576591567237034==--

