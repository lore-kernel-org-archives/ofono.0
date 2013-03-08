Content-Type: multipart/mixed; boundary="===============3628645651650318966=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 05/13] hfp_hf_bluez5: Pass version to card registration
Date: Fri, 08 Mar 2013 20:11:17 -0300
Message-ID: <1362784285-22731-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362784285-22731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3628645651650318966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Informs the HFP version of the remote device when the Audio Card is
registered.
---
 plugins/hfp_hf_bluez5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 56aa7ef..4524e13 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -454,7 +454,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 =

 	hfp =3D ofono_modem_get_data(modem);
 	hfp->msg =3D dbus_message_ref(msg);
-	hfp->card =3D ofono_handsfree_card_create(remote, local);
+	hfp->card =3D ofono_handsfree_card_create(remote, local, version);
 =

 	return NULL;
 =

-- =

1.7.11.7


--===============3628645651650318966==--

