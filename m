Content-Type: multipart/mixed; boundary="===============7020797585397041441=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] voicecall: Fix emergency number handling
Date: Wed, 19 Jan 2011 11:10:31 +0200
Message-ID: <1295428231-27485-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7020797585397041441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the SIM is present but doesn't contain any emergency numbers, the
set of emergency numbers needs to be reset to the default list. This
patch fixes the list shown in the SIM present case by removing numbers
from the list that are for the no-SIM case only.
---
 src/voicecall.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 77fa75a..fb51b41 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2095,11 +2095,11 @@ static void ecc_g2_read_cb(int ok, int total_length=
, int record,
 	DBG("%d", ok);
 =

 	if (!ok)
-		return;
+		goto check;
 =

 	if (total_length < 3) {
 		ofono_error("Unable to read emergency numbers from SIM");
-		return;
+		goto check;
 	}
 =

 	total_length /=3D 3;
@@ -2112,6 +2112,7 @@ static void ecc_g2_read_cb(int ok, int total_length, =
int record,
 								g_strdup(en));
 	}
 =

+check:
 	if (vc->new_en_list =3D=3D NULL)
 		return;
 =

@@ -2288,6 +2289,20 @@ static void sim_state_watch(enum ofono_sim_state new=
_state, void *user)
 =

 	switch (new_state) {
 	case OFONO_SIM_STATE_INSERTED:
+		/*
+		 * Free the currently being read EN list, since it
+		 * could contain ENs for the SIM not present case,
+		 * which will erroneously persist if the SIM contains
+		 * no ENs.
+		 */
+		if (vc->new_en_list) {
+			g_slist_foreach(vc->new_en_list, (GFunc) g_free, NULL);
+			g_slist_free(vc->new_en_list);
+			vc->new_en_list =3D NULL;
+		}
+
+		add_to_en_list(&vc->new_en_list, default_en_list);
+
 		/* Try both formats, only one or none will work */
 		ofono_sim_read(vc->sim, SIM_EFECC_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-- =

1.7.1


--===============7020797585397041441==--

