Content-Type: multipart/mixed; boundary="===============3219378255606278786=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] emulator: force creation of atom at modem offline state
Date: Thu, 17 Feb 2011 18:23:29 +0100
Message-ID: <1297963409-9798-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3219378255606278786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

this allows to fix problem when atom created in online state
are destroyed when modem goes to offline state
---
 src/emulator.c |    3 ++-
 src/modem.c    |   14 ++++++++++++++
 src/ofono.h    |    5 +++++
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 5744903..101b33d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -115,7 +115,8 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 =

 	em->type =3D type;
 =

-	em->atom =3D __ofono_modem_add_atom(modem, atom_t, emulator_remove, em);
+	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
+							emulator_remove, em);
 =

 	return em;
 }
diff --git a/src/modem.c b/src/modem.c
index 8567cac..bf8b0c0 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -189,6 +189,20 @@ struct ofono_atom *__ofono_modem_add_atom(struct ofono=
_modem *modem,
 	return atom;
 }
 =

+struct ofono_atom *__ofono_modem_add_atom_offline(struct ofono_modem *mode=
m,
+					enum ofono_atom_type type,
+					void (*destruct)(struct ofono_atom *),
+					void *data)
+{
+	struct ofono_atom *atom;
+
+	atom =3D __ofono_modem_add_atom(modem, type, destruct, data);
+
+	atom->modem_state =3D MODEM_STATE_OFFLINE;
+
+	return atom;
+}
+
 void *__ofono_atom_get_data(struct ofono_atom *atom)
 {
 	return atom->data;
diff --git a/src/ofono.h b/src/ofono.h
index f52356e..9d13684 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -148,6 +148,11 @@ struct ofono_atom *__ofono_modem_add_atom(struct ofono=
_modem *modem,
 					void (*destruct)(struct ofono_atom *),
 					void *data);
 =

+struct ofono_atom *__ofono_modem_add_atom_offline(struct ofono_modem *mode=
m,
+					enum ofono_atom_type type,
+					void (*destruct)(struct ofono_atom *),
+					void *data);
+
 struct ofono_atom *__ofono_modem_find_atom(struct ofono_modem *modem,
 						enum ofono_atom_type type);
 =

-- =

1.7.1


--===============3219378255606278786==--

