Content-Type: multipart/mixed; boundary="===============9034545974409150617=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/6] telit: fix shutdown of bluetooth socket
Date: Thu, 29 Sep 2011 14:54:22 -0300
Message-ID: <1317318866-9027-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317318866-9027-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9034545974409150617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/telit.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 7ed52a6..48087f2 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -474,12 +474,12 @@ static int telit_sap_enable(struct ofono_modem *modem,
 =

 	fd =3D telit_sap_open();
 	if (fd < 0)
-		return fd;
+		goto error;
 =

 	data->hw_io =3D g_io_channel_unix_new(fd);
 	if (data->hw_io =3D=3D NULL) {
 		close(fd);
-		return -ENOMEM;
+		goto error;
 	}
 =

 	g_io_channel_set_encoding(data->hw_io, NULL, NULL);
@@ -520,6 +520,9 @@ static int telit_sap_enable(struct ofono_modem *modem,
 	return -EINPROGRESS;
 =

 error:
+	shutdown(bt_fd, SHUT_RDWR);
+	close(bt_fd);
+
 	sap_close_io(modem);
 	return -EINVAL;
 }
-- =

1.7.6.2


--===============9034545974409150617==--

