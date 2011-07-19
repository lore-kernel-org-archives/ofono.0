Content-Type: multipart/mixed; boundary="===============1698169437881342208=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/3] voicecall: fix +BLDN in case of SIM not 'ready'
Date: Tue, 19 Jul 2011 18:49:09 +0200
Message-ID: <1311094151-9765-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1698169437881342208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index ce975d3..8815d9e 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2683,6 +2683,9 @@ static void sim_state_watch(enum ofono_sim_state new_=
state, void *user)
 =

 		free_sim_ecc_numbers(vc, FALSE);
 		set_new_ecc(vc);
+
+		voicecall_close_settings(vc);
+		break;
 	case OFONO_SIM_STATE_READY:
 		voicecall_load_settings(vc);
 		break;
-- =

1.7.1


--===============1698169437881342208==--

