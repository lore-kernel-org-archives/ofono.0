Content-Type: multipart/mixed; boundary="===============4280766943042861375=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/9] voicecall: Watch for changes to relevant SIM files.
Date: Tue, 15 Feb 2011 08:58:54 +0100
Message-ID: <1297756739-2958-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1297756739-2958-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4280766943042861375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 4606668..d6e8539 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2279,6 +2279,19 @@ struct ofono_voicecall *ofono_voicecall_create(struc=
t ofono_modem *modem,
 	return vc;
 }
 =

+static void read_ecc_numbers(int id, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+
+	/* Try both formats, only one or none will work */
+	ofono_sim_read(vc->sim_context, SIM_EFECC_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			ecc_g2_read_cb, vc);
+	ofono_sim_read(vc->sim_context, SIM_EFECC_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			ecc_g3_read_cb, vc);
+}
+
 static void sim_state_watch(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_voicecall *vc =3D user;
@@ -2288,13 +2301,10 @@ static void sim_state_watch(enum ofono_sim_state ne=
w_state, void *user)
 		if (vc->sim_context =3D=3D NULL)
 			vc->sim_context =3D ofono_sim_context_create(vc->sim);
 =

-		/* Try both formats, only one or none will work */
-		ofono_sim_read(vc->sim_context, SIM_EFECC_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-				ecc_g2_read_cb, vc);
-		ofono_sim_read(vc->sim_context, SIM_EFECC_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_FIXED,
-				ecc_g3_read_cb, vc);
+		read_ecc_numbers(SIM_EFECC_FILEID, vc);
+
+		ofono_sim_add_file_watch(vc->sim_context, SIM_EFECC_FILEID,
+						read_ecc_numbers, vc, NULL);
 		break;
 	case OFONO_SIM_STATE_NOT_PRESENT:
 		/* TODO: Must release all non-emergency calls */
-- =

1.7.1.86.g0e460.dirty


--===============4280766943042861375==--

