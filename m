Content-Type: multipart/mixed; boundary="===============6482290857192935318=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] sim: Add support to clear cached PINs
Date: Wed, 16 Jan 2019 12:12:00 +0530
Message-ID: <1547620920-7524-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6482290857192935318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding function to clear cached pins in case modem is disabled.
---
 include/sim.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index fad4c0d..e00e213 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -262,6 +262,8 @@ void ofono_sim_inserted_notify(struct ofono_sim *sim, o=
fono_bool_t inserted);
  */
 void ofono_sim_initialized_notify(struct ofono_sim *sim);
 =

+void ofono_sim_clear_cached_pins(struct ofono_sim *sim);
+
 struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim);
 =

 struct ofono_sim_context *ofono_sim_context_create_isim(
-- =

2.7.4


--===============6482290857192935318==--

