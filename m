Content-Type: multipart/mixed; boundary="===============3668691733371831815=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/5] include: Support for multiple SIM in emulator
Date: Mon, 02 Nov 2015 18:27:16 +0100
Message-ID: <1446485240-22049-2-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1446485240-22049-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3668691733371831815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change declarations for emulator so it is possible to handle multiple
modems in the emulator.
---
 include/emulator.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 4b2bc98..1bb80e6 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -51,6 +51,7 @@ extern "C" {
 struct ofono_emulator;
 struct ofono_emulator_request;
 struct ofono_handsfree_card;
+struct ofono_atom;
 =

 enum ofono_emulator_type {
 	OFONO_EMULATOR_TYPE_DUN,
@@ -68,7 +69,7 @@ typedef void (*ofono_emulator_request_cb_t)(struct ofono_=
emulator *em,
 					struct ofono_emulator_request *req,
 					void *data);
 =

-struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+struct ofono_emulator *ofono_emulator_create(GList *modems,
 						enum ofono_emulator_type type);
 =

 void ofono_emulator_register(struct ofono_emulator *em, int fd);
@@ -84,11 +85,11 @@ void ofono_emulator_send_intermediate(struct ofono_emul=
ator *em,
 void ofono_emulator_send_info(struct ofono_emulator *em, const char *line,
 				ofono_bool_t last);
 =

-ofono_bool_t ofono_emulator_add_handler(struct ofono_emulator *em,
+ofono_bool_t ofono_emulator_add_handler(struct ofono_atom *atom,
 					const char *prefix,
 					ofono_emulator_request_cb_t cb,
 					void *data, ofono_destroy_func destroy);
-ofono_bool_t ofono_emulator_remove_handler(struct ofono_emulator *em,
+ofono_bool_t ofono_emulator_remove_handler(struct ofono_atom *atom,
 						const char *prefix);
 =

 ofono_bool_t ofono_emulator_request_next_string(
@@ -103,8 +104,8 @@ const char *ofono_emulator_request_get_raw(struct ofono=
_emulator_request *req);
 enum ofono_emulator_request_type ofono_emulator_request_get_type(
 					struct ofono_emulator_request *req);
 =

-void ofono_emulator_set_indicator(struct ofono_emulator *em,
-					const char *name, int value);
+void ofono_emulator_set_indicator(struct ofono_atom *atom,
+						const char *name, int value);
 void ofono_emulator_set_hf_indicator_active(struct ofono_emulator *em,
 						int indicator,
 						ofono_bool_t active);
-- =

2.1.4


--===============3668691733371831815==--

