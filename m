Content-Type: multipart/mixed; boundary="===============7274599503147722772=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 8/8] hfp_hf_bluez5: Fix missing fd close
Date: Mon, 28 Jan 2013 18:11:08 -0300
Message-ID: <1359407468-5110-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359407468-5110-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7274599503147722772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fix an unusual scenario, service_level_connection() fails if
GIOChannel or GAtChat memory allocation fails.
---
 plugins/hfp_hf_bluez5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 871c720..08c6fed 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -358,10 +358,12 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
 	}
 =

 	err =3D service_level_connection(modem, fd, HFP_VERSION_LATEST);
-	if (err < 0 && err !=3D -EINPROGRESS)
+	if (err < 0 && err !=3D -EINPROGRESS) {
+		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
 					".Rejected",
 					"Not enough resources");
+	}
 =

 	hfp =3D ofono_modem_get_data(modem);
 	bt_bacpy(&hfp->src, &src.rc_bdaddr);
-- =

1.7.11.7


--===============7274599503147722772==--

