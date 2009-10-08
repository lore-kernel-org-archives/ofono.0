Content-Type: multipart/mixed; boundary="===============7100794463413632998=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: [PATCH] voicecall: allow P or , within the dial string
Date: Thu, 08 Oct 2009 19:59:54 +0300
Message-ID: <1255021194-31138-3-git-send-email-ppessi@gmail.com>
In-Reply-To: <1255021194-31138-2-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7100794463413632998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

"DTMF control digit separator" is used as pause according to GSM 02.07.
According to GSM 11.11 it is stored as BCD code 1100 in the SIM card. Nokia
modems use 'p' to represent pause. AT commands use ',' to represent pause.

Note that the interpretation of 'p' and ',' differs when used as a part of a
dial strings. When a dial string is separated from the phone number by ',',
sending the dial string starts after call is alerting. When a dial string is
separated by 'p' (DTMF control digit separator), dial string is sent only
after call is connected.
---
 src/voicecall.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index bd5358c..c69c822 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1121,6 +1121,12 @@ static DBusMessage *manager_tone(DBusConnection *con=
n,
 				(tones[i] >=3D 'A' && tones[i] <=3D 'D'))
 			continue;
 =

+		/* Pause can be described with P or , */
+		if (tones[i] =3D=3D 'P' || tones[i] =3D=3D ',') {
+			tones[i] =3D 'p';
+			continue;
+		}
+
 		g_free(tones);
 		return __ofono_error_invalid_format(msg);
 	}
-- =

1.6.0.4


--===============7100794463413632998==--

