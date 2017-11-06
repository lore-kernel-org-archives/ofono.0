Content-Type: multipart/mixed; boundary="===============6731059549562827664=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 2/5] sim: header definitions for ISIM context API
Date: Mon, 06 Nov 2017 09:49:31 -0800
Message-ID: <1509990574-19950-2-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509990574-19950-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6731059549562827664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will allow an atom to create a SIM context to an ISIM
AID (if available). It is then possible to access EF's on the
ISIM using this SIM context.
---
 include/sim.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index e10941f..23a9bc2 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -244,6 +244,10 @@ ofono_bool_t ofono_sim_remove_spn_watch(struct ofono_s=
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


--===============6731059549562827664==--

