Content-Type: multipart/mixed; boundary="===============3800833215481923343=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/2] sim: backup driver read_imsi by IMSI via EF read
Date: Mon, 09 Jan 2017 09:34:06 +0100
Message-ID: <20170109083407.3980-2-c.ronco@kerlink.fr>
In-Reply-To: <20170109083407.3980-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3800833215481923343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If read_imsi driver function fails, try to obtain IMSI via EF read
---
 src/sim.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index edd7c763..66794305 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1472,19 +1472,6 @@ static void sim_imsi_obtained(struct ofono_sim *sim,=
 const char *imsi)
 =

 }
 =

-static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
-			void *data)
-{
-	struct ofono_sim *sim =3D data;
-
-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		ofono_error("Unable to read IMSI, emergency calls only");
-		return;
-	}
-
-	sim_imsi_obtained(sim, imsi);
-}
-
 static void sim_efimsi_cb(const struct ofono_error *error,
 				const unsigned char *data, int len, void *user)
 {
@@ -1524,6 +1511,26 @@ error:
 	ofono_error("Unable to read IMSI, emergency calls only");
 }
 =

+static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
+			void *data)
+{
+	struct ofono_sim *sim =3D data;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		sim_imsi_obtained(sim, imsi);
+		return;
+	}
+
+	/* Driver function failed, try via EF reads if possible */
+	if (sim->driver->read_file_transparent =3D=3D NULL) {
+		ofono_error("Unable to read IMSI, emergency calls only");
+		return;
+	}
+
+	sim->driver->read_file_transparent(sim, SIM_EFIMSI_FILEID, 0, 9,
+						NULL, 0, sim_efimsi_cb, sim);
+}
+
 static void sim_retrieve_imsi(struct ofono_sim *sim)
 {
 	if (sim->driver->read_imsi) {
-- =

2.11.0


--===============3800833215481923343==--

