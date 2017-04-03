Content-Type: multipart/mixed; boundary="===============5293092065619979651=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 3/3] modem: set_online is valid for AlwaysOnline modems
Date: Mon, 03 Apr 2017 14:27:34 +0200
Message-ID: <20170403122734.12638-3-jonas@southpole.se>
In-Reply-To: <20170403122734.12638-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5293092065619979651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Calling set_online(TRUE) for an AlwaysOnline modem should succeed; the
modem is, after all, in the requested state when the call returns.
Returning not_implemented is not necessarily wrong, but it's a bit ugly.
---
 src/modem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index b1e8d3e..ac361be 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -754,8 +754,12 @@ static DBusMessage *set_property_online(struct ofono_m=
odem *modem,
 	if (ofono_modem_get_emergency_mode(modem) =3D=3D TRUE)
 		return __ofono_error_emergency_active(msg);
 =

-	if (modem_is_always_online(modem) =3D=3D TRUE)
-		return __ofono_error_not_implemented(msg);
+	if (modem_is_always_online(modem) =3D=3D TRUE) {
+		if (online)
+			return dbus_message_new_method_return(msg);
+		else
+			return __ofono_error_not_implemented(msg);
+	}
 =

 	modem->pending =3D dbus_message_ref(msg);
 =

-- =

2.9.3


--===============5293092065619979651==--

