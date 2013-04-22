Content-Type: multipart/mixed; boundary="===============2721135384105377267=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 2/7] core: Add "echo-canceling-and-noise-reduction"
Date: Mon, 22 Apr 2013 09:58:38 -0300
Message-ID: <1366635523-8272-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366635523-8272-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2721135384105377267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds "echo-canceling-and-noise-reduction" to "Features"
property of the Handsfree interface.
---
 src/handsfree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/handsfree.c b/src/handsfree.c
index 8a0374d..6d7f263 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -62,6 +62,9 @@ static const char **ag_features_list(unsigned int feature=
s)
 	static const char *list[33];
 	unsigned int i =3D 0;
 =

+	if (features & HFP_AG_FEATURE_ECNR)
+		list[i++] =3D "echo-canceling-and-noise-reduction";
+
 	if (features & HFP_AG_FEATURE_VOICE_RECOG)
 		list[i++] =3D "voice-recognition";
 =

-- =

1.7.11.7


--===============2721135384105377267==--

