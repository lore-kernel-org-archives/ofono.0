Content-Type: multipart/mixed; boundary="===============4951288961931340834=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: Read/Write EFcfis/EFcphs-cff
Date: Mon, 29 Nov 2010 02:37:56 -0800
Message-ID: <1291027083-19231-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4951288961931340834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

This patch reads and writes the VoiceUnconditional call forwarding status
from and to the SIM files EFcfis/EFcphs-cff. New property ForwardingFlagOnS=
im
is added to inform the status of the VoiceUnconditional status read from SI=
M.

If EFcfis is present, EFcfis file is read and the status is updated via
properties VoiceUnconditional and ForwardingFlagOnSim. If VoiceUnconditional
call forwaring rule is enabled, VoiceUnconditional property holds the
"forwared to" number whereas ForwardingFlagOnSim holds the status of the ca=
ll
forwarding rule.

If cfis is not present but EFcphs-cff is present, then EFcphs-cff is read
and the status is updated via the property ForwardingFlagOnSim. =


offline-online state transitions results in caching the call forwaring stat=
us
every time. To avoid this, call forwarding atom is moved to the post sim and
its moved also due to the fact that call forwarding status doesn't change in
roaming.

Regards,
Jeevaka


--===============4951288961931340834==--

