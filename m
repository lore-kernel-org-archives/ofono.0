Content-Type: multipart/mixed; boundary="===============7819623397899142588=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/4] Add SIM Retry Counter
Date: Mon, 20 Dec 2010 20:00:53 -0200
Message-ID: <1292882453-13942-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7819623397899142588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches add SIM Retry counter feature to ofono and implement it for
huawei modem. I verified later the the latest version of 27.007 does has a
command for querying the retry counter. This would need to be implemented as
well and it's not done yet.

The implementation reads only one "Retry Counter" that is the same as the o=
ne
being requested in PinRequired property. Another approach was to read all t=
he
counters (e.g. huawei exports counters for PIN, PIN2, PUK and PUK2), but the
Dbus API to expose to user was not so clear to me if I used this approach.
What do you think?


Lucas De Marchi (4):
  sim: add method to query SIM Retry Counter
  sim: add PinRetries property
  doc: detail PinRetries property
  atmodem: implement method to query PIN Retry Counter

 doc/sim-api.txt       |   10 +++++++
 drivers/atmodem/sim.c |   70 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/sim.h         |    5 +++
 src/sim.c             |   32 ++++++++++++++++++++++
 4 files changed, 117 insertions(+), 0 deletions(-)

-- =

1.7.3.4


--===============7819623397899142588==--

