Content-Type: multipart/mixed; boundary="===============2182568459741992886=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 2/7] include: Add ofono_emulator_set_removed_cb()
Date: Fri, 12 Apr 2013 17:41:00 -0300
Message-ID: <1365799265-19946-3-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365799265-19946-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2182568459741992886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/emulator.h b/include/emulator.h
index 5cd894b..3e8b6d9 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -67,6 +67,8 @@ typedef void (*ofono_emulator_request_cb_t)(struct ofono_=
emulator *em,
 					struct ofono_emulator_request *req,
 					void *data);
 =

+typedef void (*ofono_emulator_removed_cb_t)(void *data);
+
 struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
 						enum ofono_emulator_type type);
 =

@@ -74,6 +76,9 @@ void ofono_emulator_register(struct ofono_emulator *em, i=
nt fd);
 =

 void ofono_emulator_remove(struct ofono_emulator *em);
 =

+void ofono_emulator_set_removed_cb(struct ofono_emulator* em,
+				ofono_emulator_removed_cb_t cb, void *data);
+
 void ofono_emulator_send_final(struct ofono_emulator *em,
 				const struct ofono_error *final);
 void ofono_emulator_send_unsolicited(struct ofono_emulator *em,
-- =

1.7.9.5


--===============2182568459741992886==--

