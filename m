Content-Type: multipart/mixed; boundary="===============4627121927790136579=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 4/6] hfp_hf_bluez5: Remove Card if SLC is disconnected
Date: Thu, 28 Feb 2013 13:01:08 -0300
Message-ID: <1362067270-8632-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362067270-8632-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4627121927790136579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes previous registered Audio Card when the remote
Bluetooth device triggers the service level disconnection.
---
 plugins/hfp_hf_bluez5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 98cef7c..5db7bb8 100644
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


--===============4627121927790136579==--

