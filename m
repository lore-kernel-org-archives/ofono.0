Content-Type: multipart/mixed; boundary="===============2100750504030871799=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 6/6] hfp_hf_bluez5: Remove Audio Card when disconnection is
 requested
Date: Wed, 27 Feb 2013 17:33:54 -0300
Message-ID: <1361997234-13804-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361997234-13804-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2100750504030871799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For local initiated disconnection the GAtChat disconnect callback is not
called. For this case, Audio Card remove function needs to be called.
---
 plugins/hfp_hf_bluez5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index fb1644f..c7807bb 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -450,6 +450,9 @@ static DBusMessage *profile_disconnection(DBusConnectio=
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


--===============2100750504030871799==--

