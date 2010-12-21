Content-Type: multipart/mixed; boundary="===============5199497551480868880=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCH 2/4] sim: add ofono_sim_get_mnc_length
Date: Tue, 21 Dec 2010 11:01:17 +0200
Message-ID: <1292922079-24711-3-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1292922079-24711-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5199497551480868880==
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
index 6217a25..4cfce4a 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1911,6 +1911,14 @@ const char *ofono_sim_get_imsi(struct ofono_sim *sim)
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


--===============5199497551480868880==--

