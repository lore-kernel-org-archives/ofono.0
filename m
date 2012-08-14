Content-Type: multipart/mixed; boundary="===============6541128921446408797=="
MIME-Version: 1.0
From: Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH 2/2] dundee: explicit shutdown the bluetooth file descriptor
Date: Tue, 14 Aug 2012 04:14:32 -0300
Message-ID: <1344928472-29531-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1344928472-29531-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6541128921446408797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

If we do not shut it down the fd can remain opened. This make impossible
to try a re-connect: busy is returned in this case.

We call shutdown here to make sure that the link is always closed.
---
 dundee/bluetooth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/dundee/bluetooth.c b/dundee/bluetooth.c
index e2e2bca..9ddc72c 100644
--- a/dundee/bluetooth.c
+++ b/dundee/bluetooth.c
@@ -28,6 +28,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/socket.h>
 =

 #include <glib.h>
 =

@@ -44,6 +45,8 @@ struct bluetooth_device {
 	char *address;
 	char *name;
 =

+	int fd;
+
 	DBusPendingCall *call;
 };
 =

@@ -54,6 +57,8 @@ static void bt_disconnect(struct dundee_device *device,
 =

 	DBG("%p", bt);
 =

+	shutdown(bt->fd, SHUT_RDWR);
+
 	CALLBACK_WITH_SUCCESS(cb, data);
 }
 =

@@ -93,6 +98,8 @@ static void bt_connect_reply(DBusPendingCall *call, gpoin=
ter user_data)
 		goto done;
 	}
 =

+	bt->fd =3D fd;
+
 	CALLBACK_WITH_SUCCESS(cb, fd, cbd->data);
 =

 done:
-- =

1.7.11.2


--===============6541128921446408797==--

