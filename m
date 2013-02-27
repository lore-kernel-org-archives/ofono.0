Content-Type: multipart/mixed; boundary="===============5399377451819945378=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 1/7] handsfree-audio: Switch argument order when creating
 card
Date: Wed, 27 Feb 2013 14:58:38 -0300
Message-ID: <1361987924-497-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361987924-497-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5399377451819945378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Switch local and remote Bluetooth address arguments to follow the same
standard of the Bluetooth functions.
---
 include/handsfree-audio.h | 4 ++--
 src/handsfree-audio.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index c5403c7..b58f5db 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -30,8 +30,8 @@ extern "C" {
 =

 struct ofono_handsfree_card;
 =

-struct ofono_handsfree_card *ofono_handsfree_card_create(const char *remot=
e,
-							const char *local);
+struct ofono_handsfree_card *ofono_handsfree_card_create(const char *local,
+							const char *remote);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
 =

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index b2d4b97..399bba9 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -115,8 +115,8 @@ static const GDBusSignalTable card_signals[] =3D {
 	{ }
 };
 =

-struct ofono_handsfree_card *ofono_handsfree_card_create(const char *remot=
e,
-							const char *local)
+struct ofono_handsfree_card *ofono_handsfree_card_create(const char *local,
+							const char *remote)
 {
 	struct ofono_handsfree_card *card;
 =

-- =

1.7.11.7


--===============5399377451819945378==--

