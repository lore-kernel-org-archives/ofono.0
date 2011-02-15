Content-Type: multipart/mixed; boundary="===============5760021062399242059=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/3] emulator: add HFP emulator type
Date: Tue, 15 Feb 2011 16:06:32 +0100
Message-ID: <1297782393-9898-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1297782393-9898-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5760021062399242059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    1 +
 plugins/hfp_ag.c   |   17 +++++++++++++++++
 src/emulator.c     |   14 ++++++++++++--
 src/ofono.h        |    1 +
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 2334e02..a080399 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -32,6 +32,7 @@ struct ofono_emulator;
 =

 enum ofono_emulator_type {
 	OFONO_EMULATOR_TYPE_DUN,
+	OFONO_EMULATOR_TYPE_HFP,
 };
 =

 struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index c43275b..a45c8c1 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -94,6 +94,10 @@ static gboolean hfp_ag_disconnect_cb(GIOChannel *io, GIO=
Condition cond,
 =

 static void hfp_ag_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
 {
+	struct ofono_modem *modem;
+	struct ofono_emulator *em;
+	int fd;
+
 	DBG("");
 =

 	if (err) {
@@ -101,6 +105,19 @@ static void hfp_ag_connect_cb(GIOChannel *io, GError *=
err, gpointer user_data)
 		goto failed;
 	}
 =

+	/* Pick the first voicecall capable modem */
+	modem =3D modems->data;
+	if (modem =3D=3D NULL)
+		goto failed;
+	DBG("Picked modem %p for emulator", modem);
+
+	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_HFP);
+	if (em =3D=3D NULL)
+		goto failed;
+
+	fd =3D g_io_channel_unix_get_fd(io);
+	ofono_emulator_register(em, fd);
+
 	channel_watch =3D g_io_add_watch(io, G_IO_NVAL | G_IO_HUP | G_IO_ERR,
 					hfp_ag_disconnect_cb, NULL);
 =

diff --git a/src/emulator.c b/src/emulator.c
index c49283d..232b314 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -30,6 +30,7 @@
 =

 struct ofono_emulator {
 	struct ofono_atom *atom;
+	enum ofono_emulator_type type;
 	GAtServer *server;
 };
 =

@@ -92,16 +93,25 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 						enum ofono_emulator_type type)
 {
 	struct ofono_emulator *em;
+	enum ofono_atom_type atom_t;
 =

 	DBG("modem: %p, type: %d", modem, type);
 =

+	if (type =3D=3D OFONO_EMULATOR_TYPE_DUN)
+		atom_t =3D OFONO_ATOM_TYPE_EMULATOR_DUN;
+	else if (type =3D=3D OFONO_EMULATOR_TYPE_HFP)
+		atom_t =3D OFONO_ATOM_TYPE_EMULATOR_HFP;
+	else
+		return NULL;
+
 	em =3D g_try_new0(struct ofono_emulator, 1);
 =

 	if (em =3D=3D NULL)
 		return NULL;
 =

-	em->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_EMULATOR_DUN,
-						emulator_remove, em);
+	em->type =3D type;
+
+	em->atom =3D __ofono_modem_add_atom(modem, atom_t, emulator_remove, em);
 =

 	return em;
 }
diff --git a/src/ofono.h b/src/ofono.h
index dbe1862..f52356e 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -129,6 +129,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER,
 	OFONO_ATOM_TYPE_SIM_AUTH,
 	OFONO_ATOM_TYPE_EMULATOR_DUN,
+	OFONO_ATOM_TYPE_EMULATOR_HFP,
 };
 =

 enum ofono_atom_watch_condition {
-- =

1.7.1


--===============5760021062399242059==--

