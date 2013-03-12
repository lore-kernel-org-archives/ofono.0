Content-Type: multipart/mixed; boundary="===============0615124125872793830=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 05/20] hfp_hf_bluez5: Add user data to connect implementation
Date: Tue, 12 Mar 2013 11:21:29 -0300
Message-ID: <1363098104-16467-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0615124125872793830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the user data in the Handsfree Audio driver connect
implementation to allow accessing modem reference.
---
 plugins/hfp_hf_bluez5.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 1d26a28..0d5d5c7 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -319,7 +319,8 @@ static void card_remove(struct ofono_handsfree_card *ca=
rd)
 {
 }
 =

-static int card_audio_connect15(const char *remote, const char *local)
+static int card_audio_connect15(const char *remote, const char *local,
+								void *data)
 {
 	struct sockaddr_sco addr;
 	int sk, ret;
@@ -360,7 +361,8 @@ static struct ofono_handsfree_card_driver card_driver15=
 =3D {
 	.audio_connect	=3D card_audio_connect15,
 };
 =

-static int card_audio_connect16(const char *remote, const char *local)
+static int card_audio_connect16(const char *remote, const char *local,
+								void *data)
 {
 	return 0;
 }
-- =

1.7.11.7


--===============0615124125872793830==--

