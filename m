Content-Type: multipart/mixed; boundary="===============0363189433258520314=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/2] emulator: unref GIOChannel after creation
Date: Thu, 17 Feb 2011 16:55:25 +0100
Message-ID: <1297958126-9156-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1297958126-9156-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0363189433258520314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 567692d..5744903 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -75,6 +75,8 @@ void ofono_emulator_register(struct ofono_emulator *em, i=
nt fd)
 	if (em->server =3D=3D NULL)
 		return;
 =

+	g_io_channel_unref(io);
+
 	g_at_server_set_debug(em->server, emulator_debug, "Server");
 	g_at_server_set_disconnect_function(em->server,
 						emulator_disconnect, em);
-- =

1.7.1


--===============0363189433258520314==--

