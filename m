Content-Type: multipart/mixed; boundary="===============0208622379912275757=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 1/2] service: fix object path when unregistering msg
Date: Wed, 14 Mar 2012 11:45:59 +0100
Message-ID: <1331721962-5843-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1331721962-5843-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0208622379912275757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'value' parameter is an mms_message pointer and not a pointer to
the uuid.
Don't need to remove message from the hash table (with
g_hash_table_foreach_remove) since calling mms_message_unregister()
on every messages will remove them from the hash table.
---
 src/service.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/service.c b/src/service.c
index ef6b544..fc69e0d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -875,15 +875,12 @@ struct mms_service *mms_service_ref(struct mms_servic=
e *service)
 	return service;
 }
 =

-static gboolean unregister_message(gpointer key, gpointer value,
-							gpointer user_data)
+static void unregister_message(gpointer key, gpointer value, gpointer user=
_data)
 {
 	struct mms_service *service =3D user_data;
-	char *uuid =3D value;
+	struct mms_message *msg =3D value;
 =

-	mms_message_unregister(service, uuid);
-
-	return TRUE;
+	mms_message_unregister(service, msg->path);
 }
 =

 static void destroy_message_table(struct mms_service *service)
@@ -897,8 +894,7 @@ static void destroy_message_table(struct mms_service *s=
ervice)
 	 * This step is required because we need access to mms_service when
 	 * unregistering the message object.
 	 */
-	g_hash_table_foreach_remove(service->messages, unregister_message,
-								service);
+	g_hash_table_foreach(service->messages, unregister_message, service);
 =

 	g_hash_table_destroy(service->messages);
 	service->messages =3D NULL;
-- =

1.7.4.1


--===============0208622379912275757==--

