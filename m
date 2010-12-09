Content-Type: multipart/mixed; boundary="===============3777880038581733047=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: Read/Write EFcfis/EFcphs-cff files-v3
Date: Thu, 09 Dec 2010 09:43:54 -0800
Message-ID: <1291916641-531-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3777880038581733047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This patch reads and writes the call forwarding unconditional status from
and to the SIM depending on the SIM file availability. New property needs =

to be added due to the fact that number won't be available from the cphs-cff
file.

Incase of SIM, EFcphs-cff file holds call forwarding status and it is
represented as a flag. In case of USIM(EFcfis), we have the status flag
and also number.So, adding new property for status and using the existing
VoiceUnconditional with number will work for both SIM and USIM cases.

Other option is to have 2 properties, "VoiceUnconditional" and "Number". =

"VoiceUnconditional" will have the status of the call forwarding( "enabled",
"disabled") whereas the "Number" property will have the call forwared numbe=
r.

offline-online state transitions results in caching the call forwaring stat=
us
every time. To avoid this, call forwarding atom is moved to the post sim and
its moved also due to the fact that call forwarding status doesn't change in
roaming.

Regards,
Jeevaka

Jeevaka Badrappan (7):
  call-forwarding: Read/Write cfis/cphs-cff
  ifx: Move call forwarding to post sim
  isigen: Move call forwarding to post sim
  plugins/n900: Move call forwarding to post sim
  phonesim: Move call forwarding to post sim
  doc: Add new property to call forwarding
  TODO: Marking the Read/Write EFcfis task as done

 TODO                        |    9 --
 doc/call-forwarding-api.txt |    5 +
 doc/features.txt            |    5 +
 plugins/ifx.c               |    2 +-
 plugins/isigen.c            |    2 +-
 plugins/n900.c              |    2 +-
 plugins/phonesim.c          |    3 +-
 src/call-forwarding.c       |  256 +++++++++++++++++++++++++++++++++++++++=
+++-
 8 files changed, 270 insertions(+), 14 deletions(-)


--===============3777880038581733047==--

