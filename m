Content-Type: multipart/mixed; boundary="===============6605220475534768986=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 3/6] hfp_hf_bluez5: Remove Card when SLC fails
Date: Thu, 28 Feb 2013 13:01:07 -0300
Message-ID: <1362067270-8632-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362067270-8632-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6605220475534768986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes the previously created Audio Card if the service
level negotiation fails.
---
 plugins/hfp_hf_bluez5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 3960d7a..98cef7c 100644
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


--===============6605220475534768986==--

