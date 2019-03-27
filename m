Content-Type: multipart/mixed; boundary="===============4779642949729285650=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 3/6] sim: Added set function for CardSlotCount and
 ActiveCardSlot
Date: Wed, 27 Mar 2019 17:39:49 +0530
Message-ID: <1553688589-23308-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4779642949729285650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding set function definition for CardSlotCount and ActiveCardSlot
properties.
---
 include/sim.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index fad4c0d..be5d82f 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -132,6 +132,9 @@ typedef void (*ofono_sim_close_channel_cb_t)(const stru=
ct ofono_error *error,
 typedef void (*ofono_sim_logical_access_cb_t)(const struct ofono_error *er=
ror,
 		const unsigned char *resp, unsigned int len, void *data);
 =

+typedef void (*ofono_sim_active_slot_change_cb_t)(const struct ofono_error=
 *error,
+					void *data);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -205,6 +208,8 @@ struct ofono_sim_driver {
 	void (*logical_access)(struct ofono_sim *sim, int session_id,
 			const unsigned char *pdu, unsigned int len,
 			ofono_sim_logical_access_cb_t cb, void *data);
+	void (*set_active_sim)(struct ofono_sim *sim, unsigned int index,
+			ofono_sim_active_slot_change_cb_t cb, void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
@@ -219,6 +224,9 @@ void ofono_sim_remove(struct ofono_sim *sim);
 =

 void ofono_sim_set_data(struct ofono_sim *sim, void *data);
 void *ofono_sim_get_data(struct ofono_sim *sim);
+void ofono_sim_set_card_slot_num(struct ofono_sim *sim, unsigned int val);
+void ofono_sim_set_active_card_slot_num(struct ofono_sim *sim,
+					unsigned int val);
 =

 const char *ofono_sim_get_imsi(struct ofono_sim *sim);
 const char *ofono_sim_get_mcc(struct ofono_sim *sim);
-- =

1.9.1


--===============4779642949729285650==--

