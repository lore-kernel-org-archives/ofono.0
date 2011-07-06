Content-Type: multipart/mixed; boundary="===============7923407730017936908=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH 0/4] Add support for modem handled setup call proactive command
Date: Wed, 06 Jul 2011 03:06:09 -0700
Message-ID: <1309946773-7747-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7923407730017936908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following set of patches adds support for modem handled setup call proacti=
ve command.

Regards,
Jeevaka

Jeevaka Badrappan (4):
  include: Add driver api for user confirmation
  voicecall: api for set/clear alpha and icon id
  stk: Handle set up call in handled_notify
  ifxmodem: add support for user_confirmation in stk

 drivers/ifxmodem/stk.c |   11 +++++
 include/stk.h          |    1 +
 src/ofono.h            |    5 ++
 src/stk.c              |  108 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/voicecall.c        |   21 +++++++++
 5 files changed, 144 insertions(+), 2 deletions(-)

-- =

1.7.4.1


--===============7923407730017936908==--

