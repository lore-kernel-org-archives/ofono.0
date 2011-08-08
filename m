Content-Type: multipart/mixed; boundary="===============7444076440668713270=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3 2/2] hfp_hf: retrieve AG version
Date: Mon, 08 Aug 2011 16:34:41 +0200
Message-ID: <1312814081-15279-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1312814081-15279-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7444076440668713270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 9fa420a..6516e75 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -161,11 +161,14 @@ static DBusMessage *hfp_agent_new_connection(DBusConn=
ection *conn,
 	int fd, err;
 	struct ofono_modem *modem =3D data;
 	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
+	guint16 version;
 =

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UNIX_FD, &fd,
-				DBUS_TYPE_INVALID))
+				DBUS_TYPE_UINT16, &version, DBUS_TYPE_INVALID))
 		return __ofono_error_invalid_args(msg);
 =

+	hfp_slc_info_init(&hfp_data->info, version);
+
 	err =3D service_level_connection(modem, fd);
 	if (err < 0 && err !=3D -EINPROGRESS)
 		return __ofono_error_failed(msg);
@@ -192,7 +195,7 @@ static DBusMessage *hfp_agent_release(DBusConnection *c=
onn,
 }
 =

 static GDBusMethodTable agent_methods[] =3D {
-	{ "NewConnection", "h", "", hfp_agent_new_connection,
+	{ "NewConnection", "hq", "", hfp_agent_new_connection,
 		G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Release", "", "", hfp_agent_release },
 	{ NULL, NULL, NULL, NULL }
@@ -223,8 +226,6 @@ static int hfp_hf_probe(const char *device, const char =
*dev_addr,
 	if (data =3D=3D NULL)
 		goto free;
 =

-	hfp_slc_info_init(&data->info, HFP_VERSION_1_5);
-
 	data->handsfree_path =3D g_strdup(device);
 	if (data->handsfree_path =3D=3D NULL)
 		goto free;
-- =

1.7.1


--===============7444076440668713270==--

