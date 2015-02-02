Content-Type: multipart/mixed; boundary="===============1245986116029739594=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 0/2] Init handsfree audio manager only for Bluez5
Date: Mon, 02 Feb 2015 14:43:04 +0200
Message-ID: <1422880986-11262-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1245986116029739594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ofono should initialise Bluetooth handsfree SCO audio socket only =

with Bluez5, not with Bluez4. =

Here's one approach to work around the problem. Feel free to improve.

Tommi Kenakkala (2):
  main: Remove handsfree audio manager init and cleanup
  handsfree-audio: Init and cleanup audio manager on ref/unref calls

 src/handsfree-audio.c |   16 ++++++++--------
 src/main.c            |    4 ----
 2 files changed, 8 insertions(+), 12 deletions(-)

-- =

1.7.9.5


--===============1245986116029739594==--

