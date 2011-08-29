Content-Type: multipart/mixed; boundary="===============7126784466419637850=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 0/5] udev rules update
Date: Mon, 29 Aug 2011 18:41:46 +0200
Message-ID: <1314636111-16146-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7126784466419637850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For Speedup dongles, the aux channel is not necessarily on the last interfa=
ce (as for Speedup 8000)
So, I kept the actual logic (modem is assigned on the last interface) and I=
 added two rules for Speedup 7300 and Speedup 9800

I modified also udevng.c in order to avoid aux/modem channel assignment acc=
ording OFONO_LABEL to be overridden by the default assignment.
Note that for ZTE dongles, this overriding can't occur.
 =


Philippe Nunes (5):
  udev: Add rules to support ZTE MF668 dongle
  udev: Add rules to support ZTE MF190 dongle
  udevng.c: tty assignment according OFONO_LABEL should take precedence
  udev: Add rules to support Speedup 7300 dongle
  udev: Add rules to support SpeedUp 9800 dongle

 plugins/ofono.rules |   20 +++++++++++++++++++
 plugins/udevng.c    |   52 +++++++++++++++++++++++++++++------------------=
---
 2 files changed, 50 insertions(+), 22 deletions(-)


--===============7126784466419637850==--

