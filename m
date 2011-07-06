Content-Type: multipart/mixed; boundary="===============1870959951843470473=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stk: Use the right command pointer.
Date: Wed, 06 Jul 2011 10:40:00 +0200
Message-ID: <1309941600-17173-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1870959951843470473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index c86cbfb..fcf3991 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2890,7 +2890,7 @@ void ofono_stk_proactive_command_handled_notify(struc=
t ofono_stk *stk,
 		break;
 =

 	case STK_COMMAND_TYPE_REFRESH:
-		handle_command_refresh(stk->pending_cmd, NULL, stk);
+		handle_command_refresh(cmd, NULL, stk);
 		break;
 	}
 =

-- =

1.7.1.86.g0e460.dirty

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
z siedziba w Gdansku
ul. Slowackiego 173
80-298 Gdansk

Sad Rejonowy Gdansk Polnoc w Gdansku, =

VII Wydzial Gospodarczy Krajowego Rejestru Sadowego, =

numer KRS 101882

NIP 957-07-52-316
Kapital zakladowy 200.000 zl

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============1870959951843470473==--

