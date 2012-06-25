Content-Type: multipart/mixed; boundary="===============3081240536861672522=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/2] emulator: Fix crash when dundee is disconnecting
Date: Mon, 25 Jun 2012 16:19:52 +0200
Message-ID: <1340633992-14599-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1340633992-14599-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3081240536861672522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dundee is not waiting to receive the NO CARRIER notification
to close the IO channel with oFono so that oFono is trying to
send a NO CARRIER although GAtServer is removed.
---
 src/emulator.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c3165eb..cbee6ad 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -101,7 +101,14 @@ static void cleanup_ppp(struct ofono_emulator *em)
 	em->pns_id =3D 0;
 =

 	g_at_server_resume(em->server);
-	g_at_server_send_final(em->server, G_AT_SERVER_RESULT_NO_CARRIER);
+
+	/*
+	 * If GAtServer IO is lost, GAtServer can have been removed
+	 * through emulator disconnect routine.
+	 */
+	if (em->server !=3D NULL)
+		g_at_server_send_final(em->server,
+					G_AT_SERVER_RESULT_NO_CARRIER);
 }
 =

 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
-- =

1.7.5.4


--===============3081240536861672522==--

