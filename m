Content-Type: multipart/mixed; boundary="===============4336110966152739848=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 4/5] examples: Adapt to emulator changes
Date: Mon, 02 Nov 2015 18:27:19 +0100
Message-ID: <1446485240-22049-5-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1446485240-22049-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4336110966152739848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adapt to emulator changes for supporting multiple modems.
---
 examples/emulator.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/examples/emulator.c b/examples/emulator.c
index 5c92bd6..63499ec 100644
--- a/examples/emulator.c
+++ b/examples/emulator.c
@@ -54,6 +54,7 @@ static gboolean on_socket_connected(GIOChannel *chan, GIO=
Condition cond,
 	unsigned int len =3D sizeof(saddr);
 	int fd;
 	struct ofono_emulator *em;
+	GList *last;
 	struct ofono_modem *modem;
 =

 	if (cond !=3D G_IO_IN)
@@ -63,11 +64,16 @@ static gboolean on_socket_connected(GIOChannel *chan, G=
IOCondition cond,
 	if (fd =3D=3D -1)
 		return FALSE;
 =

-	/* Pick the first powered modem */
-	modem =3D modems->data;
+	/*
+	 * Pick the last one to avoid creating a new list with one modem just
+	 * for the call to ofono_emulator_create() (in this case we only support
+	 * registering one modem in the emulator)
+	 */
+	last =3D g_list_last(modems);
+	modem =3D last->data;
 	DBG("Picked modem %p for emulator", modem);
 =

-	em =3D ofono_emulator_create(modem, GPOINTER_TO_INT(user));
+	em =3D ofono_emulator_create(last, GPOINTER_TO_INT(user));
 	if (em =3D=3D NULL)
 		close(fd);
 	else
-- =

2.1.4


--===============4336110966152739848==--

