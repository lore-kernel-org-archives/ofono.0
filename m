Content-Type: multipart/mixed; boundary="===============8242388429884945561=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 4/5] hsp_ag: add hsp atom type
Date: Mon, 14 Mar 2011 16:49:20 +0100
Message-ID: <1300117761-6181-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300117761-6181-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8242388429884945561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    4 ++++
 src/ofono.h    |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 20a575f..855235f 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -470,6 +470,8 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		g_at_server_register(em->server, "D", dial_cb, em, NULL);
 	else if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP)
 		g_at_server_set_echo(em->server, FALSE);
+	else if (em->type =3D=3D OFONO_EMULATOR_TYPE_HSP)
+		g_at_server_set_echo(em->server, FALSE);
 }
 =

 static void emulator_remove(struct ofono_atom *atom)
@@ -493,6 +495,8 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 		atom_t =3D OFONO_ATOM_TYPE_EMULATOR_DUN;
 	else if (type =3D=3D OFONO_EMULATOR_TYPE_HFP)
 		atom_t =3D OFONO_ATOM_TYPE_EMULATOR_HFP;
+	else if (type =3D=3D OFONO_EMULATOR_TYPE_HSP)
+		atom_t =3D OFONO_ATOM_TYPE_EMULATOR_HSP;
 	else
 		return NULL;
 =

diff --git a/src/ofono.h b/src/ofono.h
index 1628df3..f294b87 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -130,6 +130,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_SIM_AUTH,
 	OFONO_ATOM_TYPE_EMULATOR_DUN,
 	OFONO_ATOM_TYPE_EMULATOR_HFP,
+	OFONO_ATOM_TYPE_EMULATOR_HSP,
 	OFONO_ATOM_TYPE_LOCATION_REPORTING,
 };
 =

-- =

1.7.1


--===============8242388429884945561==--

