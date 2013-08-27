Content-Type: multipart/mixed; boundary="===============0834829299083855224=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 0/7] bluetooth: handsfree audio agent
Date: Tue, 27 Aug 2013 18:59:36 +0200
Message-ID: <1377622783-22845-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0834829299083855224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

This is an handsfree audio agent written in C.
I could test CVSD and MSBC (upstream) with it.

v5:
updated to use BT_VOICE.
reworked the patch series to avoid modify previous patches.
Added some contribution from Frederic Danis for PTS testing.
Removed --kill and --connect options that were useless

v4:
fixes an fd leak
improves mSBC playback which could be choppy
add an option for killing an agent that connects
supports 16 bits voice settings for SCO_OPTIONS (requires kernel patch v4).

v3:
fixes a bug by which only noise was sent to remote device.
handles defered socket with following code instead of using a dummy variabl=
e:
        if (recv(thread->fd, NULL, 0, 0) < 0)

Best regards,
Fr=C3=A9d=C3=A9ric


Frederic Danis (1):
  handsfree-audio: Add USR1 signal to connect audio

Fr=C3=A9d=C3=A9ric Dalleau (6):
  handsfree-audio: Initial DBUS code
  handsfree-audio: Build handsfree-audio command line tool
  handsfree-audio: Add Alsa dependancy
  handsfree-audio: Implement alsa playback
  handsfree-audio: Add SBC dependency
  handsfree-audio: mSBC support

 .gitignore              |    1 +
 Makefile.am             |    9 +-
 configure.ac            |   10 +
 tools/handsfree-audio.c |  899 +++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 917 insertions(+), 2 deletions(-)
 create mode 100644 tools/handsfree-audio.c

-- =

1.7.9.5


--===============0834829299083855224==--

