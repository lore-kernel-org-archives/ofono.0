Content-Type: multipart/mixed; boundary="===============8177769954129371341=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 06/12] include: Add emulator init and cleanup functions
Date: Thu, 25 Apr 2013 16:09:07 -0300
Message-ID: <1366916953-12967-7-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366916953-12967-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8177769954129371341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/ofono.h b/src/ofono.h
index 8abaf1e..030e559 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -33,6 +33,9 @@ void __ofono_manager_cleanup(void);
 int __ofono_handsfree_audio_manager_init(void);
 void __ofono_handsfree_audio_manager_cleanup(void);
 =

+int __ofono_emulator_init(void);
+void __ofono_emulator_cleanup(void);
+
 void __ofono_modem_shutdown(void);
 =

 #include <ofono/log.h>
-- =

1.7.9.5


--===============8177769954129371341==--

