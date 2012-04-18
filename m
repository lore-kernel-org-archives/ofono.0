Content-Type: multipart/mixed; boundary="===============5578561441392349107=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 0/3] Poll SIM state for ZTE modem when PIN is entered
Date: Wed, 18 Apr 2012 14:16:07 +0200
Message-ID: <1334751370-5134-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5578561441392349107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This set of patch contains:
	- at_util_sim_state_query_new() function improvement,
	  add possibility to add a user data destroyer.
	- update of plugins using this new function.
	- poll SIM state for ZTE modems using this new function.

N.B.: For the moment we noticed +CME ERROR 14: SIM busy error after
having entered PIN code only on ZTE modems.

Kind regards,
Guillaume

Guillaume Zajac (3):
  atutil: Add destroyer in at_util_sim_state_query_new prototype
  plugins: Update new at_util_sim_state_query_new() prototype use
  atmodem: Poll SIM state after having entered PIN

 drivers/atmodem/atutil.c |    8 +++++++-
 drivers/atmodem/atutil.h |    3 ++-
 drivers/atmodem/sim.c    |   29 +++++++++++++++++++++++++++++
 plugins/alcatel.c        |    3 ++-
 plugins/mbm.c            |    2 +-
 plugins/samsung.c        |    3 ++-
 plugins/speedup.c        |    3 ++-
 plugins/zte.c            |    3 ++-
 8 files changed, 47 insertions(+), 7 deletions(-)

-- =

1.7.5.4


--===============5578561441392349107==--

