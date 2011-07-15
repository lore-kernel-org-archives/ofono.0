Content-Type: multipart/mixed; boundary="===============5892737271238654782=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH 0/4] Add support for modem handled setup call proactive command
Date: Fri, 15 Jul 2011 05:42:10 -0700
Message-ID: <1310733734-4206-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5892737271238654782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 This patch set fixes the review comments and also fixes some of the corner=
 cases.

 If the modem is able to setup the call, then the alpha id will be freed wh=
en the
initiated call ends.

 If the modem is not able to setup the call due to some reason, then the me=
mory
allocated for alpha id and dial request are freed when the command end/sess=
ion
end is received.

Thanks and Regards,
Jeevaka

Jeevaka Badrappan (4):
  include: Add driver api for user confirmation
  voicecall: api for set/clear alpha and icon id
  stk: Handle set up call in handled_notify
  ifxmodem: add support for user_confirmation in stk

 drivers/ifxmodem/stk.c |   11 ++++
 include/stk.h          |    1 +
 src/ofono.h            |    6 ++
 src/stk.c              |  122 ++++++++++++++++++++++++++++++++++++++++++++=
++-
 src/voicecall.c        |   76 ++++++++++++++++++++++++++++++
 5 files changed, 213 insertions(+), 3 deletions(-)

-- =

1.7.4.1


--===============5892737271238654782==--

