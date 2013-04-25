Content-Type: multipart/mixed; boundary="===============4198355173613816895=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 04/12] emulator: Register card when establish SLC
Date: Thu, 25 Apr 2013 16:09:05 -0300
Message-ID: <1366916953-12967-5-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366916953-12967-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4198355173613816895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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


--===============4198355173613816895==--

