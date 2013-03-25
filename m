Content-Type: multipart/mixed; boundary="===============4608746186766408803=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 0/9] bluetooth: handsfree audio agent
Date: Mon, 25 Mar 2013 18:16:26 +0100
Message-ID: <1364231795-13787-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4608746186766408803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

This is an handsfree audio agent written in C.
I could test CVSD and MSBC (patch v6) with it.

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


Fr=C3=A9d=C3=A9ric Dalleau (9):
  handsfree-audio: Initial DBUS code
  handsfree-audio: Build handsfree-audio command line tool
  handsfree-audio: Add Alsa dependancy
  handsfree-audio: Link tool with Alsa
  handsfree-audio: Implement alsa playback
  handsfree-audio: Add SBC dependency
  handsfree-audio: Link tool with SBC library
  handsfree-audio: mSBC support
  handsfree-audio: Add an option to kill incoming connections

 Makefile.am             |    6 +-
 configure.ac            |   10 +
 tools/handsfree-audio.c |  979 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 994 insertions(+), 1 deletion(-)
 create mode 100644 tools/handsfree-audio.c

-- =

1.7.9.5


--===============4608746186766408803==--

