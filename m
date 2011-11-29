Content-Type: multipart/mixed; boundary="===============7387091784800957982=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/5] udev rules update
Date: Tue, 29 Nov 2011 13:21:16 +0100
Message-ID: <1322569281-10908-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7387091784800957982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patches have been sent this summer but not upstreamed.
As few bugs have been opened which could be fixed by those patches, I resen=
d them
for review.

- For Speedup dongles, the logic in udevng is to assign the modem port on t=
he
latest interface. This is not true for SpeedUp SU-7300U (BUG #23168) and =

SpeedUp 9800 (BUG #23167). So, I added 2 specific rules for both dongles.

- For dongle ZTE MF190, 6 interfaces are present and we shall use the inter=
face
ttyUSB4 for modem channel. The logic in udevng is to assign the modem chann=
el
on the latest interface. To not break the support of ZTE modems with 5 =

interfaces (which are using the 4th one for PPP, like K3570), I can't extend
the current logic to take into account the ttyUSB4. So, I added a specific =
rule
for ZTE MF190.
I added also a specific rule for the dongle ZTE MF668 as the modem channel =
is
not on the latest interface (BUG #23683)

- I modified also udevng.c in order to avoid aux/modem channel assignment d=
one
according OFONO_LABEL to be overridden by the default assignment.

Philippe Nunes (5):
  udev: Add rules to support ZTE MF668 dongle
  udev: Add rules to support ZTE MF190 dongle
  udevng.c: tty assignment according OFONO_LABEL should take precedence
  udev: Add rules to support Speedup 7300 dongle
  udev: Add rules to support SpeedUp 9800 dongle

 plugins/ofono.rules |   20 ++++++++++++++++
 plugins/udevng.c    |   61 +++++++++++++++++++++++++++++++----------------=
---
 2 files changed, 58 insertions(+), 23 deletions(-)


--===============7387091784800957982==--

