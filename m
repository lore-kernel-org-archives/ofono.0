Content-Type: multipart/mixed; boundary="===============3479526843422759909=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/2] ofono_sim_ready_notify 
Date: Wed, 25 Aug 2010 04:23:10 -0700
Message-ID: <1282735392-5283-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3479526843422759909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When entering a PIN, wait for the driver to notify us that
the sim is ready before querying the password again and proceeding
with the rest of sim initialization

Kristen Carlson Accardi (2):
  sim: add ofono_sim_ready_notify() support
  atmodem: call sim_ready_notify when epev is received

 drivers/atmodem/sim.c |   12 ++++++++----
 include/sim.h         |    2 ++
 src/sim.c             |   25 +++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 6 deletions(-)

-- =

1.7.2.1


--===============3479526843422759909==--

