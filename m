Content-Type: multipart/mixed; boundary="===============3611211023525621854=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 3/9] hsp_ag: add hsp atom type
Date: Thu, 17 Mar 2011 19:55:42 +0100
Message-ID: <1300388148-925-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300388148-925-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3611211023525621854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    4 ++++
 src/ofono.h    |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c84f0a9..ce3fabd 100644
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


--===============3611211023525621854==--

