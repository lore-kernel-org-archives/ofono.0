Content-Type: multipart/mixed; boundary="===============7245270772602771764=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 6/8] sim: add function for reading only general info from
 SIM-EF file
Date: Fri, 15 Oct 2010 00:02:53 +0300
Message-ID: <1287090175-3018-7-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1287090175-3018-6-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7245270772602771764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not actual EF-contents returned, but file length, record length, file statu=
s etc.
---
 include/sim.h |   10 ++++++++++
 src/sim.c     |   21 +++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 7860e24..8dd6131 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -207,6 +207,16 @@ int ofono_sim_write(struct ofono_sim *sim, int id,
 int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
 			unsigned short offset, unsigned short num_bytes,
 			ofono_sim_file_read_cb_t cb, void *data);
+
+/*
+ * This function reads only general info from SIM-file with
+ * requested id (file length, record length, file status etc),
+ * not any records.
+ */
+int ofono_sim_read_info(struct ofono_sim *sim, int id,
+			enum ofono_sim_file_structure expected,
+			ofono_sim_file_read_cb_t cb, void *data);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/sim.c b/src/sim.c
index ab38e4f..d189350 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1710,7 +1710,7 @@ int ofono_sim_read_bytes(struct ofono_sim *sim, int i=
d,
 		return -1;
 =

 	return sim_fs_read(sim->simfs, id, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-				offset, num_bytes, cb, data);
+				FALSE, offset, num_bytes, cb, data);
 }
 =

 int ofono_sim_read(struct ofono_sim *sim, int id,
@@ -1720,7 +1720,24 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
 	if (sim =3D=3D NULL)
 		return -1;
 =

-	return sim_fs_read(sim->simfs, id, expected_type, 0, 0, cb, data);
+	return sim_fs_read(sim->simfs, id, expected_type, FALSE,
+				0, 0, cb, data);
+}
+
+int ofono_sim_read_info(struct ofono_sim *sim, int id,
+			enum ofono_sim_file_structure expected_type,
+			ofono_sim_file_read_cb_t cb, void *data)
+{
+	/*
+	 * Retrieve EF-info only (file length, record length, file status etc).
+	 * So this function doesn't retrieve actual EF-contents.
+	 */
+
+	if (sim =3D=3D NULL)
+		return -1;
+
+	return sim_fs_read(sim->simfs, id, expected_type, TRUE,
+				0, 0, cb, data);
 }
 =

 int ofono_sim_write(struct ofono_sim *sim, int id,
-- =

1.6.3.3



--===============7245270772602771764==--

