Content-Type: multipart/mixed; boundary="===============0634254428659577732=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 0/5] Add support for TextTelephony call notifications
Date: Mon, 10 Jan 2011 16:01:27 +0200
Message-ID: <1294668092-27896-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0634254428659577732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

  This is a proposal for adding TextTelephony notifications to the =

core and ifxmodem.

Regards,
Jeevaka

Jeevaka Badrappan (5):
  types: add tty flag to ofono_call
  voicecall: Add tty property support
  voicecall: Add ofono_voicecall_tty_notify api
  ifxmodem: Add support for tty call notifications
  doc: Describe TextTelephony property

 doc/voicecall-api.txt        |    7 +++++++
 drivers/ifxmodem/voicecall.c |   36 +++++++++++++++++++++++++++++++-----
 include/types.h              |    1 +
 include/voicecall.h          |    2 ++
 src/voicecall.c              |   32 ++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 5 deletions(-)


--===============0634254428659577732==--

