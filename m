Content-Type: multipart/mixed; boundary="===============7572303149926250654=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv2 04/11] sim: new API to check for a UST service only
Date: Tue, 10 Oct 2017 14:36:13 -0700
Message-ID: <1507671380-7625-4-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507671380-7625-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7572303149926250654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The existing service check API takes both SST and UST services
and could inadvertently return success on a service if one
(SST or UST) service did not exist. This adds an API specifically
for checking for a UST service, and if the UST dir is not available
it will return FALSE, rather than possibly returning true on some
other SST service.
---
 src/ofono.h | 2 ++
 src/sim.c   | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/src/ofono.h b/src/ofono.h
index a797b7f..08de17e 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -369,6 +369,8 @@ unsigned short __ofono_sms_get_next_ref(struct ofono_sm=
s *sms);
 =

 #include <ofono/sim.h>
 =

+ofono_bool_t __ofono_sim_ust_service_available(struct ofono_sim *sim,
+						int ust_service);
 ofono_bool_t __ofono_sim_service_available(struct ofono_sim *sim,
 						int ust_service,
 						int sst_service);
diff --git a/src/sim.c b/src/sim.c
index ac5b6fd..88c0421 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2289,6 +2289,15 @@ const unsigned char *ofono_sim_get_cphs_service_tabl=
e(struct ofono_sim *sim)
 	return sim->cphs_service_table;
 }
 =

+ofono_bool_t __ofono_sim_ust_service_available(struct ofono_sim *sim,
+						int ust_service)
+{
+	if (sim->efust)
+		return sim_ust_is_available(sim->efust, sim->efust_length,
+						ust_service);
+	return FALSE;
+}
+
 ofono_bool_t __ofono_sim_service_available(struct ofono_sim *sim,
 						int ust_service,
 						int sst_service)
-- =

2.7.4


--===============7572303149926250654==--

