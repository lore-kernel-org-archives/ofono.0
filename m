Content-Type: multipart/mixed; boundary="===============5887296375019316665=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 1/6] include: Add ofono_emulator_create_card()
Date: Wed, 24 Apr 2013 14:13:46 -0300
Message-ID: <1366823631-26262-2-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366823631-26262-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5887296375019316665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/emulator.h b/include/emulator.h
index 5cd894b..49168a1 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -74,6 +74,8 @@ void ofono_emulator_register(struct ofono_emulator *em, i=
nt fd);
 =

 void ofono_emulator_remove(struct ofono_emulator *em);
 =

+int ofono_emulator_create_card(struct ofono_emulator *em, int fd, int vers=
ion);
+
 void ofono_emulator_send_final(struct ofono_emulator *em,
 				const struct ofono_error *final);
 void ofono_emulator_send_unsolicited(struct ofono_emulator *em,
-- =

1.7.9.5


--===============5887296375019316665==--

