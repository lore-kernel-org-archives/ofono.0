Content-Type: multipart/mixed; boundary="===============3680244759085848427=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 3/4] sim: Add ofono_sim_get_spn()
Date: Wed, 18 Jan 2012 13:56:28 +0200
Message-ID: <1326887789-16478-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1326887789-16478-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3680244759085848427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    1 +
 src/sim.c     |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index b238868..605164e 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -183,6 +183,7 @@ void *ofono_sim_get_data(struct ofono_sim *sim);
 const char *ofono_sim_get_imsi(struct ofono_sim *sim);
 const char *ofono_sim_get_mcc(struct ofono_sim *sim);
 const char *ofono_sim_get_mnc(struct ofono_sim *sim);
+const char *ofono_sim_get_spn(struct ofono_sim *sim);
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim);
 =

 enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
diff --git a/src/sim.c b/src/sim.c
index 93b3655..e4bd378 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2151,6 +2151,14 @@ const char *ofono_sim_get_mnc(struct ofono_sim *sim)
 	return sim->mnc;
 }
 =

+const char *ofono_sim_get_spn(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return NULL;
+
+	return sim->spn;
+}
+
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
-- =

1.7.5.4


--===============3680244759085848427==--

