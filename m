Content-Type: multipart/mixed; boundary="===============2308787685704125561=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 4/4] hfp_hf_bluez5: Fix missing fd close
Date: Tue, 29 Jan 2013 17:38:40 -0300
Message-ID: <1359491920-15963-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359491920-15963-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2308787685704125561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fix an unusual scenario, service_level_connection() fails if
GIOChannel or GAtChat memory allocation fails.
---
 plugins/hfp_hf_bluez5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 28c57c3..ced5a20 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -369,10 +369,12 @@ static DBusMessage *profile_new_connection(DBusConnec=
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
 	hfp->msg =3D dbus_message_ref(msg);
-- =

1.7.11.7


--===============2308787685704125561==--

