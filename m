Content-Type: multipart/mixed; boundary="===============3773502636247643614=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 2/2] Fix __ofono_voicecall_is_busy()
Date: Thu, 23 Sep 2010 20:42:17 +0300
Message-ID: <1285263737-9017-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1285263737-9017-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3773502636247643614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Return true if call is being dialed by stk, too.
---
 src/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index f6ed988..b4017d1 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2171,7 +2171,7 @@ int ofono_voicecall_get_next_callid(struct ofono_voic=
ecall *vc)
 ofono_bool_t __ofono_voicecall_is_busy(struct ofono_voicecall *vc,
 					enum ofono_voicecall_interaction type)
 {
-	if (vc->pending)
+	if (vc->pending || vc->dial_req)
 		return TRUE;
 =

 	switch (type) {
-- =

1.7.0.4


--===============3773502636247643614==--

