Content-Type: multipart/mixed; boundary="===============4304751972510274768=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 12/14] bluetooth: Fix memory leak of adapter_any_path
Date: Mon, 03 Dec 2012 10:11:53 -0300
Message-ID: <1354540315-27731-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1354540315-27731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4304751972510274768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fixes a memory leak when BlueZ service re-connects to the
system Bus and oFono calls FindAdapter method.
---
 plugins/bluetooth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index a3dccee..6447e77 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -45,7 +45,7 @@ static GHashTable *adapter_address_hash =3D NULL;
 static gint bluetooth_refcount;
 static GSList *server_list =3D NULL;
 static const char *adapter_any_name =3D "any";
-static char *adapter_any_path;
+static char *adapter_any_path =3D NULL;
 =

 #define TIMEOUT 60 /* Timeout for user response (seconds) */
 =

@@ -733,6 +733,7 @@ static void find_adapter_cb(DBusPendingCall *call, gpoi=
nter user_data)
 	dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 					DBUS_TYPE_INVALID);
 =

+	g_free(adapter_any_path);
 	adapter_any_path =3D g_strdup(path);
 =

 	g_slist_foreach(server_list, (GFunc) add_record, NULL);
-- =

1.7.11.7


--===============4304751972510274768==--

