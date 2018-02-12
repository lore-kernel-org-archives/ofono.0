Content-Type: multipart/mixed; boundary="===============1862294620990910457=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 0/5] Add Bluetooth HFP memory index dialing V3
Date: Mon, 12 Feb 2018 20:37:13 +0200
Message-ID: <20180212183718.17194-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1862294620990910457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe De Swert <philippedeswert@gmail.com>

Hi,

Finally got some time to redo the patches from last time after all the comm=
ents.
So I renamed the functions to reflect clearly what they are for and avoid f=
unctionality
duplication, used an unsigned int as suggested for the memory index, ditche=
d callerid/CLIR
(as it is not supported for bluetooth/hfp) and avoided mixing in different =
files in one
patch as in the coding guidelines. =


Hopefully third time is the charm ;)

Philippe

Philippe De Swert (5):
  voicecall: Rename callbacks/functions related to dialing the last
    called number
  voicecall: Add support for dialing number at a given memory location
  voicecall: Add functionality to manager to dial from a memory
    location.
  hfpmodem: Add memory dialling support
  doc: Document the new DialMemory method of the voicecallmanager-api

 doc/voicecallmanager-api.txt | 11 ++++++++
 drivers/hfpmodem/voicecall.c | 25 ++++++++++++++++++
 include/voicecall.h          |  4 +++
 src/voicecall.c              | 62 +++++++++++++++++++++++++++++++++++++++-=
----
 4 files changed, 95 insertions(+), 7 deletions(-)

-- =

2.11.0


--===============1862294620990910457==--

