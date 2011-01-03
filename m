Content-Type: multipart/mixed; boundary="===============0335810540105486724=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCHv2 1/4] sim: add ofono_sim_get_mnc_length
Date: Mon, 03 Jan 2011 09:31:49 +0200
Message-ID: <1294039912-6008-2-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1294039912-6008-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0335810540105486724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    1 +
 src/sim.c     |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 7860e24..3d0c6b7 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -173,6 +173,7 @@ void ofono_sim_set_data(struct ofono_sim *sim, void *da=
ta);
 void *ofono_sim_get_data(struct ofono_sim *sim);
 =

 const char *ofono_sim_get_imsi(struct ofono_sim *sim);
+int ofono_sim_get_mnc_length(struct ofono_sim *sim);
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim);
 =

 enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
diff --git a/src/sim.c b/src/sim.c
index 335f611..8210972 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1913,6 +1913,14 @@ const char *ofono_sim_get_imsi(struct ofono_sim *sim)
 	return sim->imsi;
 }
 =

+int ofono_sim_get_mnc_length(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return 0;
+
+	return sim->mnc_length;
+}
+
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
-- =

1.7.1


--===============0335810540105486724==--

