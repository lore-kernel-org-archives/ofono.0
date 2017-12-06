Content-Type: multipart/mixed; boundary="===============2102692783122684328=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 0/7] Improve last call dialed functionality and add memory
 dialing
Date: Wed, 06 Dec 2017 17:35:57 +0200
Message-ID: <20171206153604.15080-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2102692783122684328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

Based on comments from my earlier patch series I made a new
one to add memory/favourites dialing. This patch set re-uses
parts of the common functionality of the earlier accepted =

"last call dialed" calling. It also has a fix for a small dbus
bug that crept in and I only noticed later on while testing. This
series also adds caller id support to the last call dialed =

functionality so that this is in line with the dial and dial favourites
options.

Cheers and thank you for reviewing,

Philippe

Philippe De Swert (7):
  voicecall: Support clir for last call dialing
  voicecall: Rename callbacks/functions related to dialing the last
    called number
  include/voicecall.h : Add support for dialing number at a given memory
    location
  voicecall: Fix issue with invalid dbus path
  voicecall.c : Add functionality to dial from a memory location.
  hfpmodem: Add memory dialling support
  doc: Document the new DialMemory method of the voicecallmanager-api

 doc/voicecallmanager-api.txt | 13 ++++++-
 drivers/hfpmodem/voicecall.c | 30 ++++++++++++++-
 include/voicecall.h          |  8 +++-
 src/voicecall.c              | 88 +++++++++++++++++++++++++++++++++++++++-=
----
 4 files changed, 126 insertions(+), 13 deletions(-)

-- =

2.11.0


--===============2102692783122684328==--

