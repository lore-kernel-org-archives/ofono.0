Content-Type: multipart/mixed; boundary="===============0303059159514036010=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCHV2] fix crash in case of invalid sim password type
Date: Tue, 29 Aug 2017 14:29:00 +0200
Message-ID: <1504009741-3040-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <ecbf6c15-96a2-adf9-97c0-2c83b6e2a842@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0303059159514036010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I fixed qmimodem driver instead of src/sim.c.
It will now report a failure to get SIM pin type instead of SIM pin type
OFONO_SIM_PASSWORD_INVALID.

I 've tested drivers/qmimodem/sim.c but not drivers/qmimodem/sim-legacy.c.

With my old Swedish SIM card, I now see following trace (which is OK I thin=
k):
ofonod[974]: Querying PIN authentication state failed

SimManager properties tells me that "PinRequired" property is "none".
I don't know if that's what we want to see in this case.

Best Regards and sorry for the delay,

Christophe Ronco

Christophe Ronco (1):
  qmimodem: report failure in case of invalid pin type

 drivers/qmimodem/sim-legacy.c | 5 ++++-
 drivers/qmimodem/sim.c        | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

-- =

2.7.4


--===============0303059159514036010==--

