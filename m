Content-Type: multipart/mixed; boundary="===============6489918364796144777=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 5/6] hfp_hf_bluez5: Remove Audio Card when modem is disabled
Date: Wed, 27 Feb 2013 17:33:53 -0300
Message-ID: <1361997234-13804-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361997234-13804-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6489918364796144777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index c3acd40..fb1644f 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -272,6 +272,9 @@ static int hfp_disable(struct ofono_modem *modem)
 	fd =3D g_io_channel_unix_get_fd(channel);
 	shutdown(fd, SHUT_RDWR);
 =

+	ofono_handsfree_card_remove(hfp->card);
+	hfp->card =3D NULL;
+
 	g_at_chat_unref(info->chat);
 	info->chat =3D NULL;
 =

-- =

1.7.11.7


--===============6489918364796144777==--

