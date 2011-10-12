Content-Type: multipart/mixed; boundary="===============5201975006905612946=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 12/19] include: Voice recognition in handsfree public api
Date: Wed, 12 Oct 2011 14:35:33 +0200
Message-ID: <1318422940-14955-13-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5201975006905612946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/handsfree.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/handsfree.h b/include/handsfree.h
index d39d919..68b3e5b 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -31,6 +31,8 @@ extern "C" {
 =

 struct ofono_handsfree;
 =

+typedef void (*ofono_handsfree_cb_t)(const struct ofono_error *error,
+					void *data);
 typedef void (*ofono_handsfree_phone_cb_t)(const struct ofono_error *error,
 					const struct ofono_phone_number *number,
 					void *data);
@@ -43,10 +45,15 @@ struct ofono_handsfree_driver {
 	void (*request_phone_number) (struct ofono_handsfree *hf,
 					ofono_handsfree_phone_cb_t cb,
 					void *data);
+	void (*voice_recognition)(struct ofono_handsfree *cv,
+					ofono_bool_t enabled,
+					ofono_handsfree_cb_t cb, void *data);
 };
 =

 void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
 						ofono_bool_t enabled);
+void ofono_handsfree_set_voice_recognition(struct ofono_handsfree *hf,
+						ofono_bool_t enabled);
 =

 int ofono_handsfree_driver_register(const struct ofono_handsfree_driver *d=
);
 void ofono_handsfree_driver_unregister(
-- =

1.7.6.4


--===============5201975006905612946==--

