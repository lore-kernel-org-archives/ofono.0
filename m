Content-Type: multipart/mixed; boundary="===============6130205280084072568=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] Handle the error path from service_level_connection
Date: Thu, 28 Jan 2010 15:12:52 -0200
Message-ID: <1264698772-11004-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <201001281050.16836.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6130205280084072568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 5b2cdae..0e2e359 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -367,7 +367,7 @@ static int service_level_connection(struct ofono_modem =
*modem, int fd)
 static DBusMessage *hfp_agent_new_connection(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	int fd;
+	int fd, err;
 	struct ofono_modem *modem =3D data;
 	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
 =

@@ -375,7 +375,9 @@ static DBusMessage *hfp_agent_new_connection(DBusConnec=
tion *conn,
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


--===============6130205280084072568==--

