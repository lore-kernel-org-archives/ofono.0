Content-Type: multipart/mixed; boundary="===============0374596377510724039=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/4] DTMF in dialing number
Date: Wed, 05 Sep 2012 19:19:35 +0200
Message-ID: <1346865579-24794-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0374596377510724039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

GCF test cases unveiled the following requirements not currently
supported by oFono:

- Dialing number provided by Setup Call can include a pause character
followed by a DTMF string.

I noticed that DTMFs concatenated to the dialing number are likely to be
handled directly by the modem. So, I suggest to include the pause character
as an acceptable digit in the phone number.

- Dialing number provided by Setup Call can be greater than 20 digits.

- AID shall not be displayed in case of self explanatory icon
As I'm not sure if it is intended to not take into account this icon qualif=
ier
I just implemented a fix in stk.c
If you agree with this requirement, then we would need to check the icon
qualifier in each Stkagent method.

Philippe.

Philippe Nunes (4):
  stk: convert to phone number format
  common: Accept pause character in the dialing number
  voicecall: Accept long phone number format for STK
  stk: AID shall not be displayed in case of self explanatory icon

 src/common.c    |    2 +-
 src/stk.c       |   55 ++++++++++++++++++++++++++++++++++++++++-----------=
----
 src/voicecall.c |    2 +-
 3 files changed, 42 insertions(+), 17 deletions(-)

-- =

1.7.9.5


--===============0374596377510724039==--

