Content-Type: multipart/mixed; boundary="===============5699562336986412368=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 03/20] hfp_hf_bluez5: Pass modem as user data
Date: Tue, 12 Mar 2013 11:21:27 -0300
Message-ID: <1363098104-16467-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5699562336986412368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the modem reference as user data when the Handsfree
Audio Card is created, allowing to access the service level connection
in the connect callback.
---
 plugins/hfp_hf_bluez5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 810107f..1d26a28 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -495,7 +495,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 =

 	hfp =3D ofono_modem_get_data(modem);
 	hfp->msg =3D dbus_message_ref(msg);
-	hfp->card =3D ofono_handsfree_card_create(remote, local, version);
+	hfp->card =3D ofono_handsfree_card_create(remote, local, version, modem);
 =

 	return NULL;
 =

-- =

1.7.11.7


--===============5699562336986412368==--

