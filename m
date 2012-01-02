Content-Type: multipart/mixed; boundary="===============0045791520203123224=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: [PATCH] sim: fix typo: "network" is matching pin type for "networkpuk"
Date: Mon, 02 Jan 2012 14:27:26 +0200
Message-ID: <1325507246-10210-1-git-send-email-jussi.kukkonen@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0045791520203123224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

At least this looks like a typo -- can't say I know anything about the
stranger pin types though...


 src/sim.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 4412db8..ceead1e 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -194,7 +194,7 @@ static enum ofono_sim_password_type puk2pin(enum ofono_=
sim_password_type type)
 	case OFONO_SIM_PASSWORD_SIM_PUK2:
 		return OFONO_SIM_PASSWORD_SIM_PIN2;
 	case OFONO_SIM_PASSWORD_PHNET_PUK:
-		return OFONO_SIM_PASSWORD_PHNET_PUK;
+		return OFONO_SIM_PASSWORD_PHNET_PIN;
 	case OFONO_SIM_PASSWORD_PHNETSUB_PUK:
 		return OFONO_SIM_PASSWORD_PHNETSUB_PIN;
 	case OFONO_SIM_PASSWORD_PHSP_PUK:
-- =

1.7.7.3


--===============0045791520203123224==--

