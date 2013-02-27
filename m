Content-Type: multipart/mixed; boundary="===============3223567714945740153=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 3/6] hfp_hf_bluez5: Remove Audio Card when SLC fails
Date: Wed, 27 Feb 2013 17:33:51 -0300
Message-ID: <1361997234-13804-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361997234-13804-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3223567714945740153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes the previously created Audio Card if the service
level negotiation fails.
---
 plugins/hfp_hf_bluez5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 97d2f07..359c8fd 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -112,6 +112,9 @@ static void slc_failed(gpointer userdata)
 	ofono_error("Service level connection failed");
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


--===============3223567714945740153==--

