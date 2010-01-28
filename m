Content-Type: multipart/mixed; boundary="===============0477928016811125720=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/2] Handle the error path from service_level_connection
Date: Thu, 28 Jan 2010 11:32:43 -0200
Message-ID: <1264685563-13042-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1264685563-13042-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0477928016811125720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 2d0faa8..d9d3bda 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -377,7 +377,7 @@ static int service_level_connection(struct ofono_modem =
*modem, int fd)
 =

 static DBusMessage *hfp_agent_new_connection(DBusConnection *conn, DBusMes=
sage *msg, void *data)
 {
-	int fd;
+	int fd, err;
 	struct ofono_modem *modem =3D data;
 	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
 =

@@ -385,7 +385,9 @@ static DBusMessage *hfp_agent_new_connection(DBusConnec=
tion *conn, DBusMessage *
 				DBUS_TYPE_INVALID))
 		return __ofono_error_invalid_args(msg);
 =

-	service_level_connection(modem, fd);
+	err =3D service_level_connection(modem, fd);
+	if (err < 0 && err !=3D -EINPROGRESS)
+		return __ofono_error_failed(msg);
 =

 	hfp_data->slc_msg =3D msg;
 	dbus_message_ref(msg);
-- =

1.6.4.4


--===============0477928016811125720==--

