Content-Type: multipart/mixed; boundary="===============3243822543478747940=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] emulator: fix dun_ath_cb() not to remove GAtServer
 io_disconnect() CB
Date: Thu, 19 May 2011 15:03:14 +0200
Message-ID: <1305810194-24360-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3243822543478747940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c17b901..251bed8 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -219,15 +219,19 @@ static void dun_ath_cb(GAtServer *server, GAtServerRe=
questType type,
 		if (val !=3D 0)
 			goto error;
 =

+		g_at_server_suspend(em->server);
 		g_at_ppp_unref(em->ppp);
 		em->ppp =3D NULL;
+		g_at_server_resume(em->server);
 =

 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
 		break;
 =

 	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		g_at_server_suspend(em->server);
 		g_at_ppp_unref(em->ppp);
 		em->ppp =3D NULL;
+		g_at_server_resume(em->server);
 =

 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
 		break;
-- =

1.7.1


--===============3243822543478747940==--

