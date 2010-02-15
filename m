Content-Type: multipart/mixed; boundary="===============8683888847820311026=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/3] hfp: remove duplicated ofono_modem_set_powered
Date: Mon, 15 Feb 2010 17:26:34 -0200
Message-ID: <1266261996-15507-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8683888847820311026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 2d03973..411cfc1 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -110,8 +110,6 @@ static void service_level_conn_failed(struct ofono_mode=
m *modem)
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 	DBusMessage *msg;
 =

-	ofono_modem_set_powered(modem, FALSE);
-
 	msg =3D g_dbus_create_error(data->slc_msg, HFP_AGENT_ERROR_INTERFACE
 					".Failed",
 					"HFP Handshake failed");
-- =

1.6.4.4


--===============8683888847820311026==--

