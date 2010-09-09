Content-Type: multipart/mixed; boundary="===============2268481930384728598=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: Add support for Send USSD proactive command handling
Date: Thu, 09 Sep 2010 05:31:44 -0700
Message-ID: <1284035516-21359-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2268481930384728598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

  Following patches adds the support for Send USSD proactive command.
This also includes support for setting the character set using CSCS.
USSD driver API changed to accept dcs, binary data and length. USSD
atom drivers changed to reflect the API change.

Find the change statistics information as follows

 drivers/atmodem/atutil.c |   78 ++++++++++++++++++++
 drivers/atmodem/atutil.h |   26 +++++++
 drivers/atmodem/ussd.c   |   99 +++++++++++++++-----------
 drivers/isimodem/ussd.c  |   44 ++++--------
 include/types.h          |    1 +
 include/ussd.h           |    8 ++-
 plugins/atgen.c          |   59 +++++++++++++++
 plugins/phonesim.c       |   54 ++++++++++++++
 src/call-barring.c       |    5 ++
 src/call-forwarding.c    |    5 ++
 src/call-settings.c      |    5 ++
 src/ofono.h              |   26 +++++++
 src/stk.c                |  141 ++++++++++++++++++++++++++++++++++++-
 src/stkutil.c            |   35 +++++++++
 src/stkutil.h            |   13 ++++
 src/ussd.c               |  179 +++++++++++++++++++++++++++++++++++++++++-=
----
 16 files changed, 683 insertions(+), 95 deletions(-)

Regards,
jeevaka

--===============2268481930384728598==--

