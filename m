Content-Type: multipart/mixed; boundary="===============6349991763240860418=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] call-volume: Minor coding style fix
Date: Fri, 26 Nov 2010 06:57:45 -0800
Message-ID: <1290783465-5541-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6349991763240860418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-volume.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/call-volume.c b/src/call-volume.c
index dd1be92..0accdf2 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -114,7 +114,6 @@ static DBusMessage *cv_get_properties(DBusConnection *c=
onn,
 	dbus_bool_t muted;
 =

 	reply =3D dbus_message_new_method_return(msg);
-
 	if (!reply)
 		return NULL;
 =

-- =

1.7.0.4


--===============6349991763240860418==--

