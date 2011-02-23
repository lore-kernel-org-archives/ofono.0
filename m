Content-Type: multipart/mixed; boundary="===============8620647917551694685=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/2] emulator: Disable echo for hfp emulators
Date: Wed, 23 Feb 2011 14:19:13 +0100
Message-ID: <1298467153-2426-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1298467153-2426-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8620647917551694685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index dcfd296..7007882 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -203,6 +203,8 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 =

 	if (em->type =3D=3D OFONO_EMULATOR_TYPE_DUN)
 		g_at_server_register(em->server, "D", dial_cb, em, NULL);
+	else if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP)
+		g_at_server_set_echo(em->server, FALSE);
 }
 =

 static void emulator_remove(struct ofono_atom *atom)
-- =

1.7.1


--===============8620647917551694685==--

