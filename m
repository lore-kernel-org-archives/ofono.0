Content-Type: multipart/mixed; boundary="===============4954722978245506128=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 6/8] sim: getters for mcc and mnc definition
Date: Tue, 18 Jan 2011 10:09:30 +0200
Message-ID: <1295338172-12773-7-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295338172-12773-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4954722978245506128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 830322a..81df60e 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -178,6 +178,8 @@ void ofono_sim_set_data(struct ofono_sim *sim, void *da=
ta);
 void *ofono_sim_get_data(struct ofono_sim *sim);
 =

 const char *ofono_sim_get_imsi(struct ofono_sim *sim);
+const char *ofono_sim_get_mcc(struct ofono_sim *sim);
+const char *ofono_sim_get_mnc(struct ofono_sim *sim);
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim);
 =

 enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
-- =

1.7.1


--===============4954722978245506128==--

