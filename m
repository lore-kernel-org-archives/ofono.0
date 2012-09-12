Content-Type: multipart/mixed; boundary="===============2725332888533487446=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 3/6] service: Process delivery_ind notification
Date: Wed, 12 Sep 2012 15:55:10 +0200
Message-ID: <1347458113-29039-4-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1347458113-29039-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2725332888533487446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 104 insertions(+)

diff --git a/src/service.c b/src/service.c
index ab88370..e867aa1 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1300,6 +1300,107 @@ static void emit_service_removed(struct mms_service=
 *service)
 				&service->path, DBUS_TYPE_INVALID);
 }

+static gboolean get_meta_by_msgid(struct mms_service *service,
+						const char *msgid,
+						char *uuid)
+{
+	GDir *dir;
+	GKeyFile *meta;
+	const char *file;
+	const char *homedir;
+	const char *service_id;
+	char *service_path;
+
+	homedir =3D g_get_home_dir();
+	if (homedir =3D=3D NULL)
+		return FALSE;
+
+	service_id =3D service->identity;
+
+	service_path =3D g_strdup_printf("%s/.mms/%s/", homedir, service_id);
+
+	dir =3D g_dir_open(service_path, 0, NULL);
+	g_free(service_path);
+	if (dir =3D=3D NULL)
+		return FALSE;
+
+	while ((file =3D g_dir_read_name(dir)) !=3D NULL) {
+		char *id;
+
+		if (g_str_has_suffix(file, MMS_META_UUID_SUFFIX) =3D=3D FALSE)
+			continue;
+
+		if (strlen(file) !=3D MMS_META_UUID_LEN +
+						MMS_META_UUID_SUFFIX_LEN)
+			continue;
+
+		strncpy(uuid, file, MMS_META_UUID_LEN);
+		uuid[MMS_META_UUID_LEN] =3D 0;
+
+		meta =3D mms_store_meta_open(service_id, uuid);
+		if (meta =3D=3D NULL)
+			goto bail;
+
+		id =3D g_key_file_get_string(meta, "info", "id", NULL);
+
+		mms_store_meta_close(service_id, uuid, meta, FALSE);
+
+		if (id =3D=3D NULL)
+			continue;
+
+		if (g_strcmp0(msgid, id) =3D=3D 0) {
+			g_free(id);
+			g_dir_close(dir);
+			return TRUE;
+		}
+
+		g_free(id);
+	}
+
+bail:
+	g_dir_close(dir);
+
+	mms_error("Report received with unmatched message id <%s>", msgid);
+
+	return FALSE;
+}
+
+static void process_delivery_ind_notification(struct mms_service *service,
+						struct mms_message *di_msg)
+{
+	GKeyFile *meta;
+	char uuid[MMS_META_UUID_LEN + 1];
+	char *path;
+	char *to;
+
+	if (get_meta_by_msgid(service, di_msg->di.msgid, uuid) =3D=3D FALSE)
+		goto exit;
+
+	meta =3D mms_store_meta_open(service->identity, uuid);
+	if (meta =3D=3D NULL)
+		return;
+
+	to =3D g_strdup(di_msg->di.to);
+
+	mms_address_to_string(to);
+
+	g_key_file_set_string(meta, "delivery_status", to,
+				delivery_status[di_msg->di.dr_status - 127]);
+
+	g_free(to);
+
+	mms_store_meta_close(service->identity, uuid, meta, TRUE);
+
+	path =3D g_strdup_printf("%s/%s/%s", MMS_PATH, service->identity, uuid);
+
+	g_free(path);
+
+exit:
+	mms_store_remove(service->identity, di_msg->uuid);
+
+	mms_message_free(di_msg);
+}
+
 static gboolean load_message_from_store(const char *service_id,
 				const char *uuid, struct mms_message *msg)
 {
@@ -1485,6 +1586,7 @@ register_sr:
 		}
 	} else if (msg->type =3D=3D MMS_MESSAGE_TYPE_DELIVERY_IND) {
 		request =3D NULL;
+		process_delivery_ind_notification(service, msg);
 	} else
 		request =3D NULL;

@@ -2403,6 +2505,8 @@ void mms_service_push_notify(struct mms_service *serv=
ice,

 		mms_store_meta_close(service->identity, uuid, meta, TRUE);

+		process_delivery_ind_notification(service, msg);
+
 		return;
 	}

--
1.7.9.5


--===============2725332888533487446==--

