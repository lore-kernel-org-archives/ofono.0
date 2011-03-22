Content-Type: multipart/mixed; boundary="===============6742296561506604195=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/6] Introduction of BIP commands (STK classe 'e')
Date: Tue, 22 Mar 2011 13:51:14 +0100
Message-ID: <1300798280-4281-1-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6742296561506604195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following set of patches introduces the preliminary support of the BIP =
commands:
- Open channel
- Close channel
- Receive data
- Send data
- Get channel status
Next step is precisely the channel setup (through a connman plugin) and the=
 Rx/Tx data buffer management.

Philippe Nunes (6):
  test-stkutil: Add unit tests for BIP commands
  stk-api.txt: Describe new d-bus APIs related to BIP commands.
  stk: Introduce BIP command handlers
  stkagent: Add new methods to support the BIP commands
  stkutil: Complete the TLV parsing/builder to support BIP commands
  test-stk-menu: Add support for BIP commands

 doc/stk-api.txt     |   27 ++-
 src/stk.c           |  307 +++++++++++++
 src/stkagent.c      |  129 ++++++
 src/stkagent.h      |   17 +
 src/stkutil.c       |  300 ++++++++++++-
 src/stkutil.h       |  141 ++++++-
 test/test-stk-menu  |   22 +
 unit/test-stkutil.c | 1201 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 8 files changed, 2087 insertions(+), 57 deletions(-)


--===============6742296561506604195==--

