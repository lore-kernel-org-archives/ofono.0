Content-Type: multipart/mixed; boundary="===============8777138756992874946=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 6/6] hfp_hf_bluez5: Remove Card on RequestDisconnection
Date: Thu, 28 Feb 2013 13:01:10 -0300
Message-ID: <1362067270-8632-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362067270-8632-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8777138756992874946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For local initiated disconnection the GAtChat disconnect callback is not
called. For this case, Audio Card remove function needs to be called.
---
 plugins/hfp_hf_bluez5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index d35a20f..2db2fa5 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -454,6 +454,9 @@ static DBusMessage *profile_disconnection(DBusConnectio=
n *conn,
 	hfp =3D ofono_modem_get_data(modem);
 	info =3D &hfp->info;
 =

+	ofono_handsfree_card_remove(hfp->card);
+	hfp->card =3D NULL;
+
 	g_at_chat_unref(info->chat);
 	info->chat =3D NULL;
 =

-- =

1.7.11.7


--===============8777138756992874946==--

