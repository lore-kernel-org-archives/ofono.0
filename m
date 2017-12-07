Content-Type: multipart/mixed; boundary="===============7209775804278411729=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] sim: Handle multiple EFpl read completions
Date: Thu, 07 Dec 2017 20:09:36 +0300
Message-ID: <1512666576-28999-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7209775804278411729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since sim_efli_efpl_changed() can be invoked several times before
completion of SIM reads (which are not cancellable), followed by
multiple completions, it's not enough to free old sim->language_prefs
in sim_efli_efpl_changed(). The same thing has to be done by
sim_efpl_read_cb() to avoid leaking memory e.g. after this
sequence of calls:

  1. sim_efli_efpl_changed()
  2. sim_efli_efpl_changed()
  3. sim_efpl_read_cb()
  4. sim_efpl_read_cb()

One such scenario involves __ofono_sim_refresh() calling
sim_efli_efpl_changed() first with id=3DSIM_EFPL_FILEID,
like this:

  #0  sim_efli_efpl_changed (id=3D12037)
  #1  sim_fs_notify_file_watches (id=3D-1)
  #2  __ofono_sim_refresh (file_list=3D0x0, full_file_change=3D1, naa_init=
=3D1)
  #3  handle_command_refresh ()
  #4  ofono_stk_proactive_command_handled_notify ()
  ...

and then with id=3D28421 (SIM_EFLI_FILEID), so both files are
re-read twice, the second result overwriting the first one
and the first one getting lost (leaked). Since SIM reads are
asynchronous and take considerable time, I'm quite sure that
there are other scenarios as well.

In fact it's even better to keep the old sim->language_prefs
around until EFpl read is finished, to avoid issuing unnecessary
PropertyChanged signal if the second read produces the same
result, which it normally does.
---
 src/sim.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 2538c77..2585f06 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2081,6 +2081,26 @@ static char **concat_lang_prefs(GSList *a, GSList *b)
 	return ret;
 }
 =

+static gboolean strv_equal(char **sv1, char **sv2)
+{
+	const guint len1 =3D sv1 ? g_strv_length(sv1) : 0;
+	const guint len2 =3D sv2 ? g_strv_length(sv2) : 0;
+
+	if (len1 =3D=3D len2) {
+		guint i;
+
+		for (i =3D 0; i < len1; i++) {
+			if (strcmp(sv1[i], sv2[i])) {
+				return FALSE;
+			}
+		}
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static void sim_efpl_read_cb(int ok, int length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
@@ -2091,6 +2111,7 @@ static void sim_efpl_read_cb(int ok, int length, int =
record,
 	gboolean efli_format =3D TRUE;
 	GSList *efli =3D NULL;
 	GSList *efpl =3D NULL;
+	char **old_prefs =3D sim->language_prefs;
 =

 	if (!ok || length < 2)
 		goto skip_efpl;
@@ -2142,13 +2163,15 @@ skip_efpl:
 		g_slist_free_full(efpl, g_free);
 	}
 =

-	if (sim->language_prefs !=3D NULL)
+	if (!strv_equal(sim->language_prefs, old_prefs))
 		ofono_dbus_signal_array_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
 						"PreferredLanguages",
 						DBUS_TYPE_STRING,
 						&sim->language_prefs);
 =

+	g_strfreev(old_prefs);
+
 	/* Proceed with sim initialization if we're not merely updating */
 	if (!sim->language_prefs_update)
 		__ofono_sim_recheck_pin(sim);
@@ -2200,11 +2223,6 @@ static void sim_efli_efpl_changed(int id, void *user=
data)
 	if (sim->efli !=3D NULL) /* This shouldn't happen */
 		return;
 =

-	if (sim->language_prefs) {
-		g_strfreev(sim->language_prefs);
-		sim->language_prefs =3D NULL;
-	}
-
 	sim->language_prefs_update =3D true;
 =

 	ofono_sim_read(sim->early_context, SIM_EFLI_FILEID,
-- =

1.9.1


--===============7209775804278411729==--

