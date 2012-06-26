Content-Type: multipart/mixed; boundary="===============4959882793718951976=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 1/2] emulator: Test already done in g_at_server_resume()
Date: Tue, 26 Jun 2012 10:12:58 +0200
Message-ID: <1340698379-22509-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4959882793718951976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index e7c7d41..c3165eb 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -100,9 +100,6 @@ static void cleanup_ppp(struct ofono_emulator *em)
 	__ofono_private_network_release(em->pns_id);
 	em->pns_id =3D 0;
 =

-	if (em->server =3D=3D NULL)
-		return;
-
 	g_at_server_resume(em->server);
 	g_at_server_send_final(em->server, G_AT_SERVER_RESULT_NO_CARRIER);
 }
-- =

1.7.5.4


--===============4959882793718951976==--

