Content-Type: multipart/mixed; boundary="===============3247667269814196700=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC PATCH 7/9] modem: restrict operations allowed in emergency
Date: Thu, 31 Mar 2011 09:18:30 -0700
Message-ID: <1301588312-6932-8-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3247667269814196700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 126c0e6..49b3314 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -662,6 +662,9 @@ static DBusMessage *set_property_online(struct ofono_mo=
dem *modem,
 	if (modem->online =3D=3D online)
 		return dbus_message_new_method_return(msg);
 =

+	if (ofono_modem_get_emergency_mode(modem) =3D=3D TRUE)
+		return __ofono_error_emergency_active(msg);
+
 	if (driver->set_online =3D=3D NULL)
 		return __ofono_error_not_implemented(msg);
 =

@@ -906,6 +909,9 @@ static DBusMessage *set_property_lockdown(struct ofono_=
modem *modem,
 		goto done;
 	}
 =

+	if (ofono_modem_get_emergency_mode(modem) =3D=3D TRUE)
+		return __ofono_error_emergency_active(msg);
+
 	modem->lock_owner =3D g_strdup(caller);
 =

 	modem->lock_watch =3D g_dbus_add_disconnect_watch(conn,
@@ -998,6 +1004,9 @@ static DBusMessage *modem_set_property(DBusConnection =
*conn,
 		if (modem->powered =3D=3D powered)
 			return dbus_message_new_method_return(msg);
 =

+		if (ofono_modem_get_emergency_mode(modem) =3D=3D TRUE)
+			return __ofono_error_emergency_active(msg);
+
 		if (modem->lockdown)
 			return __ofono_error_access_denied(msg);
 =

-- =

1.7.0.4


--===============3247667269814196700==--

