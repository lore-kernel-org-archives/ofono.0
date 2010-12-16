Content-Type: multipart/mixed; boundary="===============1686478904872242178=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready PATCHv3 0/3] ofono_sim_ready_notify
Date: Thu, 16 Dec 2010 21:57:43 +0200
Message-ID: <1292529466-19284-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1686478904872242178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Hi all,

Here is my 4th stab at the ofono_sim_ready_notify().

The ofono_sim_ready_notify() is now always expected after call to
query_passwd_state.

When ofono_sim_ready_notify() is invoked, it checks that the call is
expected and if needed, retries the query_passwd_state, otherwise it
proceeds with sim initialization.

The patches has now been tested with the PIN and PUK codes with mbm and
the new isimodem sim driver by Jukka Saunamaki.

--Pekka

Jukka Saunamaki (1):
  isimodem/sim: added PIN and SIM state handling

Pekka Pessi (2):
  sim: add ofono_sim_ready_notify
  atmodem/sim: use ofono_sim_ready_notify

 drivers/atmodem/sim.c    |  166 ++++++++++-----
 drivers/isimodem/debug.c |   32 +++
 drivers/isimodem/debug.h |    3 +
 drivers/isimodem/sim.c   |  537 ++++++++++++++++++++++++++++++++++++++++++=
+---
 drivers/isimodem/sim.h   |   50 +++++-
 include/sim.h            |    2 +
 src/sim.c                |   56 ++++--
 7 files changed, 747 insertions(+), 99 deletions(-)


--===============1686478904872242178==--

