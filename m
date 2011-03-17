Content-Type: multipart/mixed; boundary="===============8898569181240209405=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 7/9] emulator: add audio connection API
Date: Thu, 17 Mar 2011 19:55:46 +0100
Message-ID: <1300388148-925-8-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300388148-925-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8898569181240209405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index e010606..1657f56 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -56,6 +56,9 @@ typedef void (*ofono_emulator_request_cb_t)(struct ofono_=
emulator *em,
 					struct ofono_emulator_request *req,
 					void *data);
 =

+typedef void (*ofono_emulator_audio_conn_cb_t)(struct ofono_emulator *em,
+					void *data);
+
 struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
 						enum ofono_emulator_type type);
 =

@@ -94,6 +97,10 @@ enum ofono_emulator_request_type ofono_emulator_request_=
get_type(
 void ofono_emulator_set_indicator(struct ofono_emulator *em,
 					const char *name, int value);
 =

+void ofono_emulator_set_audio_connect_handler(struct ofono_emulator *em,
+					ofono_emulator_audio_conn_cb_t cb,
+					void *user_data);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============8898569181240209405==--

