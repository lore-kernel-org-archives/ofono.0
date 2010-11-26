Content-Type: multipart/mixed; boundary="===============5037703811597050094=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: Read/Write EFcfis/EFcphs-cff files 
Date: Thu, 25 Nov 2010 22:23:30 -0800
Message-ID: <1290752617-19024-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5037703811597050094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

This patch reads and writes the call forwarding unconditional status
from and to the SIM depending on the SIM file availability.
New property needs to be added due to the fact that number won't be
available from the cphs-cff file.

Incase of SIM, EFcphs-cff file holds call forwarding status and it
is represented as a flag. In case of USIM(EFcfis), we have the status
flag and also number.So, adding new property for status and using the
existing VoiceUnconditional with number will work for both SIM and USIM cas=
es.

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

--===============5037703811597050094==--

