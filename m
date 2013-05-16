Content-Type: multipart/mixed; boundary="===============3782793956477101024=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 04/22] emulator: Register card when establish SLC
Date: Thu, 16 May 2013 14:16:24 -0300
Message-ID: <1368724602-27781-5-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3782793956477101024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the service level connection is established, the emulator now
registers its Handsfree Audio Card. This registers a DBus interface
for that card.
---
 src/emulator.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 48998f5..b75d0bd 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -641,6 +641,9 @@ done:
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
 =

 		em->slc =3D TRUE;
+
+		ofono_handsfree_card_register(em->card);
+
 		break;
 	}
 =

-- =

1.7.9.5


--===============3782793956477101024==--

