Content-Type: multipart/mixed; boundary="===============5539879385094441695=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v3 05/12] include: Add audio transport set API
Date: Mon, 02 Apr 2012 15:27:15 +0200
Message-ID: <1333373242-11117-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333373242-11117-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5539879385094441695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 5cd894b..4b78667 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -72,6 +72,9 @@ struct ofono_emulator *ofono_emulator_create(struct ofono=
_modem *modem,
 =

 void ofono_emulator_register(struct ofono_emulator *em, int fd);
 =

+void ofono_emulator_set_audio_transport(struct ofono_emulator *em,
+						const char *path);
+
 void ofono_emulator_remove(struct ofono_emulator *em);
 =

 void ofono_emulator_send_final(struct ofono_emulator *em,
-- =

1.7.1


--===============5539879385094441695==--

