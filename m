Content-Type: multipart/mixed; boundary="===============8110460013872166015=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 3/3] service: fix for message_delete bug
Date: Fri, 20 Apr 2012 18:39:06 +0200
Message-ID: <1334939946-8835-4-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334939946-8835-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8110460013872166015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mms_message_unregister destroyes the message
---
 src/service.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index 5520012..f89fd3f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -134,6 +134,7 @@ static DBusMessage *msg_delete(DBusConnection *conn,
 	struct mms_service *service =3D user_data;
 	struct mms_message *mms;
 	const char *path;
+	char *uuid;
 =

 	path =3D dbus_message_get_path(msg);
 =

@@ -143,10 +144,14 @@ static DBusMessage *msg_delete(DBusConnection *conn,
 	if (mms =3D=3D NULL)
 		return __mms_error_invalid_args(msg);
 =

+	uuid =3D g_strdup(mms->uuid);
+
 	if (mms_message_unregister(service, path) < 0)
 		return __mms_error_invalid_args(msg);
 =

-	mms_store_remove(service->identity, mms->uuid);
+	mms_store_remove(service->identity, uuid);
+
+	g_free(uuid);
 =

 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
-- =

1.7.4.4


--===============8110460013872166015==--

