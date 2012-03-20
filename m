Content-Type: multipart/mixed; boundary="===============6929516326535373096=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 2/3] service: fixed possible meta with NULL uuid
Date: Tue, 20 Mar 2012 19:42:22 +0100
Message-ID: <1332268943-24300-3-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1332268943-24300-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6929516326535373096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If mms_store_file fails.
---
 src/service.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index 3fdf4e0..0161ec0 100644
--- a/src/service.c
+++ b/src/service.c
@@ -767,6 +767,15 @@ static DBusMessage *send_message(DBusConnection *conn,
 =

 	msg->uuid =3D g_strdup(mms_store_file(service->identity,
 						request->data_path));
+	if (msg->uuid =3D=3D NULL) {
+		release_attachement_data(msg->attachments);
+		mms_message_free(msg);
+
+		unlink(request->data_path);
+		mms_request_destroy(request);
+
+		return __mms_error_trans_failure(dbus_msg);
+	}
 =

 	meta =3D mms_store_meta_open(service->identity, msg->uuid);
 	if (meta =3D=3D NULL) {
-- =

1.7.4.4


--===============6929516326535373096==--

