Content-Type: multipart/mixed; boundary="===============6806314259477400117=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 20/20] sap: do a proper shutdown of the channels
Date: Mon, 05 Sep 2011 15:03:49 -0300
Message-ID: <1315245829-6887-21-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315245829-6887-20-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6806314259477400117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 3a764ef..5886703 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -184,6 +184,8 @@ static void sap_remove(struct ofono_modem *modem)
 static void sap_power_down(DBusPendingCall *call, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
 	DBusMessage *reply;
 	DBusError derr;
 =

@@ -196,6 +198,14 @@ static void sap_power_down(DBusPendingCall *call, gpoi=
nter user_data)
 		goto done;
 	}
 =

+	g_io_channel_unref(data->bt_io);
+	if (data->bt_watch > 0)
+		g_source_remove(data->bt_watch);
+
+	g_io_channel_unref(data->hw_io);
+	if (data->hw_watch > 0)
+		g_source_remove(data->hw_watch);
+
 	ofono_modem_set_powered(modem, FALSE);
 =

 done:
@@ -280,12 +290,14 @@ static void sap_connect_reply(DBusPendingCall *call, =
gpointer user_data)
 	fd =3D sap_driver->open(data->hw_modem);
 	if (!fd)  {
 		g_io_channel_unref(data->bt_io);
+		g_source_remove(data->bt_watch);
 		return;
 	}
 =

 	data->hw_io =3D g_io_channel_unix_new(fd);
 	if (data->hw_io =3D=3D NULL) {
 		g_io_channel_unref(data->bt_io);
+		g_source_remove(data->bt_watch);
 		close(fd);
 		return;
 	}
-- =

1.7.6.1


--===============6806314259477400117==--

