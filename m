Content-Type: multipart/mixed; boundary="===============0483060930008666855=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [PATCH 0/3] Long dial string support (2nd)
Date: Mon, 22 Nov 2010 18:36:26 +0200
Message-ID: <cover.1290436058.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0483060930008666855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dial strings can now be as long as 120 digits (not counting '+'). This feat=
ure
is going to be needed by the FDN feature.

An FDN may consist of a phone number plus a DTMF string. In order to have t=
he
call succeed when FDN is enabled, both parts need to be provided when makin=
g a
call, as a single dial string.

For AT modems the long dial string can be and has to be passed as is to the
modem, for ISI modems the dial string needs to be split into phone number (=
dest.
address sub block) and DTMF tone (post dest. address sub block) before feed=
ing
it to the modem.

Andras Domokos (3):
  common: add long dial string support
  voicecall: add long dial string support
  isimodem/voicecall: add long dial string support

 drivers/isimodem/voicecall.c |   83 +++++++++++++++++++++++++++++++++-----=
----
 include/types.h              |    2 +-
 src/common.c                 |   38 +++++++++++++++++---
 src/common.h                 |    1 +
 src/voicecall.c              |    6 ++--
 5 files changed, 103 insertions(+), 27 deletions(-)


--===============0483060930008666855==--

