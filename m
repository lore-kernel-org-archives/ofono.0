Content-Type: multipart/mixed; boundary="===============4012462504706336639=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: Fix issues in ofono_sim_get_phase and its usage
Date: Mon, 06 Dec 2010 10:39:15 -0800
Message-ID: <1291660757-6684-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4012462504706336639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch adds the missing OFONO_SIM_PHASE_UNKNOWN check in some
of the functions which uses ofono_sim_get_phase. Also fixed the issue
in ofono_get_sim_phase when the passed sim paramter is NULL. =

 =

Jeevaka Badrappan (2):
  sim: fix minor issue in ofono_sim_get_phase
  simfs: Add unknown sim phase check

 src/sim.c   |    2 +-
 src/simfs.c |    9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)


--===============4012462504706336639==--

