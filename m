Content-Type: multipart/mixed; boundary="===============0188274279454451026=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] sim: Add support to clear cached PINs
Date: Thu, 03 Jan 2019 16:34:04 +0530
Message-ID: <1546513444-13242-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0188274279454451026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding function to clear cached pins in case modem is disabled.
---
 include/sim.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index fad4c0d..b0a0911 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -262,6 +262,8 @@ void ofono_sim_inserted_notify(struct ofono_sim *sim, o=
fono_bool_t inserted);
  */
 void ofono_sim_initialized_notify(struct ofono_sim *sim);
 =

+void ofono_sim_clear_cached_pins(void);
+
 struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim);
 =

 struct ofono_sim_context *ofono_sim_context_create_isim(
-- =

2.7.4


--===============0188274279454451026==--

