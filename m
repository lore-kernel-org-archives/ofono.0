Content-Type: multipart/mixed; boundary="===============4660482683911194422=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/4] stemgr: watch for signals only on MGR_SERVICE
Date: Thu, 28 Jun 2012 10:59:20 -0300
Message-ID: <1340891961-9809-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1340891961-9809-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4660482683911194422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/stemgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/stemgr.c b/plugins/stemgr.c
index 126ec4e..7e434d3 100644
--- a/plugins/stemgr.c
+++ b/plugins/stemgr.c
@@ -337,8 +337,8 @@ static gboolean property_changed(DBusConnection *connec=
tion,
 =

 static void mgr_connect(DBusConnection *connection, void *user_data)
 {
-	property_changed_watch =3D g_dbus_add_signal_watch(connection, NULL,
-						NULL,
+	property_changed_watch =3D g_dbus_add_signal_watch(connection,
+						MGR_SERVICE, NULL,
 						MGR_MODEM_INTERFACE,
 						PROPERTY_CHANGED,
 						property_changed,
-- =

1.7.11.1


--===============4660482683911194422==--

