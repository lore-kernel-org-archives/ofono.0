Content-Type: multipart/mixed; boundary="===============3061734456621489146=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] voicecall: allow pause to be sent through SendTones()
Date: Fri, 18 Mar 2011 20:39:47 -0300
Message-ID: <1300491587-1400-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3061734456621489146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

manager_tone() converts all tone chars to uppercase. Since everywhere we
check for both 'p' and 'P' for a pause, tone_queue() should also check
both before claiming the string is invalid.
---
 src/voicecall.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index cb5258d..4932ffa 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -287,8 +287,9 @@ static int tone_queue(struct ofono_voicecall *vc, const=
 char *tone_str,
 	 */
 	for (i =3D 0; tone_str[i]; i++)
 		if (!g_ascii_isdigit(tone_str[i]) && tone_str[i] !=3D 'p' &&
-				tone_str[i] !=3D '*' && tone_str[i] !=3D '#' &&
-				(tone_str[i] < 'A' || tone_str[i] > 'D'))
+				tone_str[i] !=3D 'P' && tone_str[i] !=3D '*' &&
+				tone_str[i] !=3D '#' && (tone_str[i] < 'A' ||
+				tone_str[i] > 'D'))
 			return -EINVAL;
 =

 	while ((entry =3D g_queue_peek_nth(vc->toneq, n++)) !=3D NULL)
-- =

1.7.4.1


--===============3061734456621489146==--

