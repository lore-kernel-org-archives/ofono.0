Content-Type: multipart/mixed; boundary="===============0905082815368185249=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 2/5] sim: add function for retrieving only EF-info
Date: Thu, 21 Oct 2010 17:58:10 +0300
Message-ID: <1287673093-3022-3-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1287673093-3022-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0905082815368185249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d87c71f..fe34188 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1241,6 +1241,16 @@ static void sim_retrieve_imsi(struct ofono_sim *sim)
 	sim->driver->read_imsi(sim, sim_imsi_cb, sim);
 }
 =

+int ofono_sim_read_info(struct ofono_sim *sim, int id,
+			enum ofono_sim_file_structure expected_type,
+			ofono_sim_fs_read_info_cb_t cb, void *data)
+{
+	if (sim =3D=3D NULL)
+		return -1;
+
+	return sim_fs_read_info(sim->simfs, id, expected_type, cb, data);
+}
+
 static void sim_efsst_read_cb(int ok, int length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
-- =

1.6.3.3



--===============0905082815368185249==--

