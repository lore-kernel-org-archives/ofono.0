Content-Type: multipart/mixed; boundary="===============1045282444284952189=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/9] Add cdip support
Date: Wed, 12 Jan 2011 09:27:38 -0200
Message-ID: <1294831667-7447-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1045282444284952189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Following patches add support for cdip in oFono. It's implement in atmodem =
and
tested with phonesim.

As I understood from 27.007, this property only makes sense for incoming ca=
lls,
so the property in voicecall atom is only presented in this case (and if the
network actually sent this field).

Last patch is only a style fix.

Lucas De Marchi (9):
  include: add cdip field in ofono_call
  voicecall: add support for cdip
  atmodem: add cdip to voicecall
  doc: add CalledLineIdentification property to voicecall
  include: add method for querying cdip support
  call-settings: add support for cdip
  atmodem: add cdip to call-settings
  doc: add CalledLinePresentation property to CallSettings
  call-settings: apply rule M11 of coding style

 doc/call-settings-api.txt       |   15 ++++++
 doc/voicecall-api.txt           |    9 +++
 drivers/atmodem/call-settings.c |   26 +++++++++
 drivers/atmodem/voicecall.c     |   61 +++++++++++++++++++++-
 include/call-settings.h         |    2 +
 include/types.h                 |    1 +
 src/call-settings.c             |  107 ++++++++++++++++++++++++++++++++---=
----
 src/voicecall.c                 |   38 +++++++++++++-
 8 files changed, 236 insertions(+), 23 deletions(-)

-- =

1.7.3.5


--===============1045282444284952189==--

