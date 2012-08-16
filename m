Content-Type: multipart/mixed; boundary="===============0317723607146945439=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 1/3] sim: add function to get password type
Date: Thu, 16 Aug 2012 09:37:18 +0200
Message-ID: <1345102640-8465-1-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <50292E2D.8040403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0317723607146945439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: August Mayer <august.mayer@hale.at>

---
 include/sim.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 508ff24..3e5797c 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -189,6 +189,8 @@ enum ofono_sim_phase ofono_sim_get_phase(struct ofono_s=
im *sim);
 enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
 const unsigned char *ofono_sim_get_cphs_service_table(struct ofono_sim *si=
m);
 =

+enum ofono_sim_password_type ofono_sim_get_password_type(struct ofono_sim =
*sim);
+
 unsigned int ofono_sim_add_state_watch(struct ofono_sim *sim,
 					ofono_sim_state_event_cb_t cb,
 					void *data, ofono_destroy_func destroy);
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============0317723607146945439==--

