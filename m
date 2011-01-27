Content-Type: multipart/mixed; boundary="===============1177212967860971116=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 1/3] sim: add ofono_sim_get_spn API header
Date: Thu, 27 Jan 2011 15:22:15 +0200
Message-ID: <1296134537-16133-2-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1296134537-16133-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1177212967860971116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 5e3ba5b..7e573fd 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -180,6 +180,8 @@ void *ofono_sim_get_data(struct ofono_sim *sim);
 const char *ofono_sim_get_imsi(struct ofono_sim *sim);
 const char *ofono_sim_get_mcc(struct ofono_sim *sim);
 const char *ofono_sim_get_mnc(struct ofono_sim *sim);
+const char *ofono_sim_get_spn(struct ofono_sim *sim);
+unsigned char ofono_sim_get_spn_dc(struct ofono_sim *sim);
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim);
 =

 enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
-- =

1.7.1


--===============1177212967860971116==--

