Content-Type: multipart/mixed; boundary="===============7508222613670428407=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/6] Add SIM Retry Counter
Date: Tue, 14 Dec 2010 23:36:26 -0200
Message-ID: <1292376992-1888-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7508222613670428407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches add SIM Retry counter feature to ofono and implement it for
huawei modem.

First two patches are only fixes for huawei when SIM card is initially lock=
ed and
were necessary in order to test the other patches. Without them ofono wrong=
ly
reports as if the SIM was not present because there's not difference between
"invalid SIM" state and "locked SIM" state for huwaei.

The implementation reads only one "Retry Counter" that is the same as the o=
ne
being requested in PinRequired property. Another approach was to read all t=
he
counters (e.g. huawei exports counters for PIN, PIN2, PUK and PUK2), but the
Dbus API to expose to user was not so clear to me if I used this approach.
What do you think?


Lucas De Marchi (6):
  huawei: cancel poll timeout when going to a valid state
  huawei: fix SIM state notification when locked
  sim: add method to query SIM Retry Counter
  sim: add PinRetries property
  doc: detail PinRetries property
  atmodem: implement method to query PIN Retry Counter

 doc/sim-api.txt       |   10 +++++++
 drivers/atmodem/sim.c |   70 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/sim.h         |    5 +++
 plugins/huawei.c      |   46 ++++++++++++++++++++++++++++++++
 src/sim.c             |   32 ++++++++++++++++++++++
 5 files changed, 163 insertions(+), 0 deletions(-)

-- =

1.7.3.3


--===============7508222613670428407==--

