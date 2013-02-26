Content-Type: multipart/mixed; boundary="===============3041359627512561200=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 6/9] handsfree-audio: Remove Audio Card for local initiated
 disconnection
Date: Tue, 26 Feb 2013 10:50:50 -0300
Message-ID: <1361886653-30873-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361886653-30873-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3041359627512561200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes a registered Handsfree Audio Card when the local host
requests disconnection of the service level connection.
---
 plugins/hfp_hf_bluez5.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 26946af..494f33c 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -427,6 +427,12 @@ static DBusMessage *profile_disconnection(DBusConnecti=
on *conn,
 	hfp =3D ofono_modem_get_data(modem);
 	info =3D &hfp->info;
 =

+	if (hfp->card) {
+		ofono_handsfree_card_remove(hfp->card);
+		g_free(hfp->card);
+		hfp->card =3D NULL;
+	}
+
 	g_at_chat_unref(info->chat);
 	info->chat =3D NULL;
 =

-- =

1.7.11.7


--===============3041359627512561200==--

