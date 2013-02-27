Content-Type: multipart/mixed; boundary="===============4914350071879298209=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 5/7] hfp_hf_bluez5: Remove Audio Card when SLC is
 disconnected
Date: Wed, 27 Feb 2013 14:58:42 -0300
Message-ID: <1361987924-497-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361987924-497-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4914350071879298209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes previous registered Audio Card when the remote
Bluetooth device triggers the service level disconnection.
---
 plugins/hfp_hf_bluez5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index bc99107..341d99f 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -129,6 +129,9 @@ static void hfp_disconnected_cb(gpointer user_data)
 =

 	ofono_modem_set_powered(modem, FALSE);
 =

+	ofono_handsfree_card_remove(hfp->card);
+	hfp->card =3D NULL;
+
 	g_at_chat_unref(info->chat);
 	info->chat =3D NULL;
 }
-- =

1.7.11.7


--===============4914350071879298209==--

