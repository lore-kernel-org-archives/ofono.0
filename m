Content-Type: multipart/mixed; boundary="===============2595433000865425834=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 1/3] include: Add ofono_emulator_set_handsfree_card
Date: Tue, 06 Oct 2015 12:48:12 +0200
Message-ID: <1444128494-31742-2-git-send-email-simon.fels@canonical.com>
In-Reply-To: <1444128494-31742-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2595433000865425834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Denis Kenzior <denkenz@gmail.com>

---
 include/emulator.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/emulator.h b/include/emulator.h
index 5e8d431..15dc61c 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -50,6 +50,7 @@ extern "C" {
 =

 struct ofono_emulator;
 struct ofono_emulator_request;
+struct ofono_handsfree_card;
 =

 enum ofono_emulator_type {
 	OFONO_EMULATOR_TYPE_DUN,
@@ -108,6 +109,9 @@ void ofono_emulator_set_hf_indicator_active(struct ofon=
o_emulator *em,
 						int indicator,
 						ofono_bool_t active);
 =

+void ofono_emulator_set_handsfree_card(struct ofono_emulator *em,
+					struct ofono_handsfree_card *card);
+
 #ifdef __cplusplus
 }
 #endif
-- =

2.5.0


--===============2595433000865425834==--

