Content-Type: multipart/mixed; boundary="===============7091669493123082157=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] dbus: Make cme_errors_mapping static const
Date: Thu, 28 Jun 2018 18:51:55 +0300
Message-ID: <1530201115-8345-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7091669493123082157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index 3e1e162..cadf5c6 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -37,7 +37,7 @@ struct error_mapping_entry {
 	DBusMessage *(*ofono_error_func)(DBusMessage *);
 };
 =

-struct error_mapping_entry cme_errors_mapping[] =3D {
+static const struct error_mapping_entry cme_errors_mapping[] =3D {
 	{ 3,	__ofono_error_not_allowed },
 	{ 4,	__ofono_error_not_supported },
 	{ 16,	__ofono_error_incorrect_password },
@@ -422,7 +422,7 @@ DBusMessage *__ofono_error_network_terminated(DBusMessa=
ge *msg)
 DBusMessage *__ofono_error_from_error(const struct ofono_error *error,
 						DBusMessage *msg)
 {
-	struct error_mapping_entry *e;
+	const struct error_mapping_entry *e;
 	int maxentries;
 	int i;
 =

-- =

1.9.1


--===============7091669493123082157==--

