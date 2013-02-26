Content-Type: multipart/mixed; boundary="===============8052056521305058595=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 5/9] handsfree-audio: Remove Audio Card when HFP is removed
Date: Tue, 26 Feb 2013 10:50:49 -0300
Message-ID: <1361886653-30873-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361886653-30873-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8052056521305058595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes a registered Handsfree Audio Card when the HFP remove
callback gets called.
---
 plugins/hfp_hf_bluez5.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index f22b030..26946af 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -129,6 +129,7 @@ static void hfp_disconnected_cb(gpointer user_data)
 	if (hfp->card) {
 		ofono_handsfree_card_remove(hfp->card);
 		g_free(hfp->card);
+		hfp->card =3D NULL;
 	}
 =

 	g_at_chat_unref(info->chat);
@@ -216,6 +217,12 @@ static void hfp_remove(struct ofono_modem *modem)
 	if (hfp->msg)
 		dbus_message_unref(hfp->msg);
 =

+	if (hfp->card) {
+		ofono_handsfree_card_remove(hfp->card);
+		g_free(hfp->card);
+		hfp->card =3D NULL;
+	}
+
 	g_at_chat_unref(info->chat);
 =

 	g_free(hfp);
-- =

1.7.11.7


--===============8052056521305058595==--

