Content-Type: multipart/mixed; boundary="===============3862077051010035123=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 00/11] Initial support for Handsfree Audio Manager
Date: Tue, 19 Feb 2013 17:44:41 -0300
Message-ID: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3862077051010035123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following patches implement the initial functionality of the experiment=
al
Handsfree Audio Manager interface defined in doc/handsfree-audio-api.txt

This series add the Register and Unregister methods. A new plugin "hfp_audi=
o"
is being added allowing to share the functions between AG and HF.


Claudio Takahasi (9):
  hfp_audio: Adds initial plugin files
  ofono: Add option for experimental interfaces
  dbus: Move oFono error define to dbus.h
  hfp_audio: Add initial manager methods declaration
  hfp_audio: Add "Register" agent arguments parsing
  hfp_audio: Free agents when exiting
  hfp_audio: Call Agent "Release" when exiting
  hfp_audio: Add Agent "Unregister"
  hfp_audio: Add Agent tracking

Vinicius Costa Gomes (2):
  hfp_audio: Add codec array validation
  hfp_audio: Add repeated Agent registration verification

 Makefile.am         |   3 +
 include/dbus.h      |   1 +
 plugins/hfp_audio.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/dbus.c          |   2 -
 src/main.c          |   9 +++
 5 files changed, 242 insertions(+), 2 deletions(-)
 create mode 100644 plugins/hfp_audio.c

-- =

1.7.11.7


--===============3862077051010035123==--

