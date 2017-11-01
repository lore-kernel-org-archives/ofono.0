Content-Type: multipart/mixed; boundary="===============3949327307199585717=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 6/8] sim: header definitions for AID sim context API
Date: Wed, 01 Nov 2017 10:33:46 -0700
Message-ID: <1509557628-15121-6-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509557628-15121-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3949327307199585717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will allow an atom to create a SIM context to a specific
AID on the sim, which it can then access EF's on through the
context.
---
 include/sim.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index aeceef6..30f6c2d 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -239,6 +239,10 @@ ofono_bool_t ofono_sim_remove_spn_watch(struct ofono_s=
im *sim, unsigned int *id)
 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d);
 =

 struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim);
+
+struct ofono_sim_context *ofono_sim_context_create_isim(
+		struct ofono_sim *sim);
+
 void ofono_sim_context_free(struct ofono_sim_context *context);
 =

 /* This will queue an operation to read all available records with id from=
 the
-- =

2.7.4


--===============3949327307199585717==--

