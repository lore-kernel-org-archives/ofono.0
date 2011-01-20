Content-Type: multipart/mixed; boundary="===============7540576139933364648=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] core: Always return success to a no-op
Date: Thu, 20 Jan 2011 12:55:13 +0200
Message-ID: <1295520913-17243-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7540576139933364648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A SetProperty that doesn't actually change the Online property's state
when no change to that state is pending, should not fail. It should
always succeed regardless of the current modem state.
---
 src/modem.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index f587766..e966a6e 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -580,15 +580,15 @@ static DBusMessage *set_property_online(struct ofono_=
modem *modem,
 	if (modem->pending !=3D NULL)
 		return __ofono_error_busy(msg);
 =

+	if (modem->online =3D=3D online)
+		return dbus_message_new_method_return(msg);
+
 	if (driver->set_online =3D=3D NULL)
 		return __ofono_error_not_implemented(msg);
 =

 	if (modem->modem_state < MODEM_STATE_OFFLINE)
 		return __ofono_error_not_available(msg);
 =

-	if (modem->online =3D=3D online)
-		return dbus_message_new_method_return(msg);
-
 	modem->pending =3D dbus_message_ref(msg);
 =

 	driver->set_online(modem, online,
-- =

1.7.1


--===============7540576139933364648==--

