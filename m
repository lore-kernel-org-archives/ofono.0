Content-Type: multipart/mixed; boundary="===============2159341825467048680=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 4/6] emulator: Register card when establish SLC
Date: Wed, 24 Apr 2013 14:13:49 -0300
Message-ID: <1366823631-26262-5-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366823631-26262-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2159341825467048680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 8acdae1..4d5e835 100644
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


--===============2159341825467048680==--

