Content-Type: multipart/mixed; boundary="===============5853086789199386785=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 07/12] emulator: Implement init and cleanup functions
Date: Thu, 25 Apr 2013 16:09:08 -0300
Message-ID: <1366916953-12967-8-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366916953-12967-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5853086789199386785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 079a5b8..8ac79d5 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -1335,3 +1335,12 @@ void __ofono_emulator_set_indicator_forced(struct of=
ono_emulator *em,
 			ind->deferred =3D TRUE;
 	}
 }
+
+int __ofono_emulator_init(void)
+{
+	return 0;
+}
+
+void __ofono_emulator_cleanup(void)
+{
+}
-- =

1.7.9.5


--===============5853086789199386785==--

