Content-Type: multipart/mixed; boundary="===============7684574900015939148=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [RFC v3 0/8] bluetooth: handsfree audio agent
Date: Tue, 12 Mar 2013 19:00:40 +0100
Message-ID: <1363111248-1694-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7684574900015939148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

This is an handsfree audio agent written in C.
I could test CVSD and MSBC with this version.
v3 fixes a bug by which noise could be sent to remote device.
it handles defered socket with the following code instead of using a dummy
variable:
        if (recv(thread->fd, NULL, 0, 0) < 0)

Best regards,
Fr=C3=A9d=C3=A9ric


Fr=C3=A9d=C3=A9ric Dalleau (8):
  handsfree-audio: Initial DBUS code
  handsfree-audio: Build handsfree-audio command line tool
  handsfree-audio: Add Alsa dependancy
  handsfree-audio: Link tool with Alsa
  handsfree-audio: Implement alsa playback
  handsfree-audio: Add SBC dependency
  handsfree-audio: Link tool with SBC library
  handsfree-audio: mSBC support

 Makefile.am             |    6 +-
 configure.ac            |   10 +
 tools/handsfree-audio.c |  971 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 986 insertions(+), 1 deletion(-)
 create mode 100644 tools/handsfree-audio.c

-- =

1.7.9.5


--===============7684574900015939148==--

