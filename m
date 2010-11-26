Content-Type: multipart/mixed; boundary="===============8694040489597448049=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] call-volume: Minor coding style fix
Date: Fri, 26 Nov 2010 13:21:06 -0800
Message-ID: <1290806466-6776-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <4CF02091.3020601@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8694040489597448049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-volume.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/call-volume.c b/src/call-volume.c
index 6411467..6f692f3 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -114,8 +114,7 @@ static DBusMessage *cv_get_properties(DBusConnection *c=
onn,
 	dbus_bool_t muted;
 =

 	reply =3D dbus_message_new_method_return(msg);
-
-	if (!reply)
+	if (reply =3D=3D NULL)
 		return NULL;
 =

 	dbus_message_iter_init_append(reply, &iter);
-- =

1.7.0.4


--===============8694040489597448049==--

