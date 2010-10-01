Content-Type: multipart/mixed; boundary="===============6996265026192724525=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 2/4] modem: Remove atoms if FD is enabled in the SIM-card
Date: Fri, 01 Oct 2010 19:06:39 +0300
Message-ID: <1285949201-2994-3-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1285949201-2994-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6996265026192724525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 7a29edf..f6ed1ab 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -419,6 +419,9 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *user)
 		break;
 	case OFONO_SIM_STATE_INSERTED:
 		break;
+	case OFONO_SIM_STATE_FAILED:
+		modem_change_state(modem, MODEM_STATE_POWER_OFF);
+		break;
 	case OFONO_SIM_STATE_READY:
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
 =

-- =

1.6.3.3



--===============6996265026192724525==--

