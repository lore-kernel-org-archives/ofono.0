Content-Type: multipart/mixed; boundary="===============5846235791388730104=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 1/4] Do not automatically remove watches for service names
Date: Mon, 01 Mar 2010 18:07:44 +0200
Message-ID: <2d5a2c101003010807u1c2785d1hcdac4b5668623fb6@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5846235791388730104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Services can be owned again so it is perfectly fine to keep the watch.
---
 gdbus/watch.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 1d479fa..e85f288 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -386,18 +386,19 @@ static DBusHandlerResult
service_filter(DBusConnection *connection,
 				cb->conn_func(connection, cb->user_data);
 		}

+		/* Only auto remove if it is a bus name watch */
+		if (data->argument[0] =3D=3D ':' &&
+				(!cb->conn_func || !cb->disc_func)) {
+			filter_data_remove_callback(data, cb);
+			continue;
+		}
+
 		/* Check if the watch was removed/freed by the callback
 		 * function */
 		if (!g_slist_find(data->callbacks, cb))
 			continue;

 		data->callbacks =3D g_slist_remove(data->callbacks, cb);
-
-		if (!cb->conn_func || !cb->disc_func) {
-			g_free(cb);
-			continue;
-		}
-
 		data->processed =3D g_slist_append(data->processed, cb);
 	}

-- =

Luiz Augusto von Dentz
Computer Engineer

--===============5846235791388730104==--

