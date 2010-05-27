Content-Type: multipart/mixed; boundary="===============5125791444914442068=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH] Keep modem state consistent if sim is removed while online is
 being changed.
Date: Thu, 27 May 2010 19:29:51 +0300
Message-ID: <1274977791-2038-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5125791444914442068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 2cb3e50..0fa8a67 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -410,14 +410,16 @@ static void online_cb(const struct ofono_error *error=
, void *data)
 	struct ofono_modem *modem =3D data;
 	DBusMessage *reply;
 =

-	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
+		modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
 		reply =3D dbus_message_new_method_return(modem->pending);
 	else
 		reply =3D __ofono_error_failed(modem->pending);
 =

 	__ofono_dbus_pending_reply(&modem->pending, reply);
 =

-	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
+		modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
 		modem_change_state(modem, MODEM_STATE_ONLINE);
 }
 =

@@ -433,7 +435,8 @@ static void offline_cb(const struct ofono_error *error,=
 void *data)
 =

 	__ofono_dbus_pending_reply(&modem->pending, reply);
 =

-	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
+		modem->modem_state =3D=3D MODEM_STATE_ONLINE)
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
 }
 =

-- =

1.6.3.3


--===============5125791444914442068==--

