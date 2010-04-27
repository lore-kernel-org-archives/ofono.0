Content-Type: multipart/mixed; boundary="===============3597226671035032692=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: Modem emulator and DUN server side for oFono and BlueZ
Date: Tue, 27 Apr 2010 15:53:54 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351D9FE1FA@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3597226671035032692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am now working on modem emulator and one usage is for DUN server role. Si=
nce Padovan is working on client role, it's good to share my rough thinking=
 for server side implementation. Here are the simple steps I have:

1. Create an oFono emulator atom in oFono. It's the emulator manager that c=
ould create DUN, HFP AG or SPP type emulators. It exposes dbus methods like=
 CreateEmulator, DestroyEmulator, GetProperty, etc.

2. DUN agent server in BlueZ watch oFono and call CreateEmulator and pass t=
he file descriptor to oFono. This server could further implement HFP AG and=
 SPP connection.

3. Once an emulator is created, other atom like voicecall, grps, sms regist=
er their interested AT command handlers to it. The goal is that we could ha=
ndle all mandatory AT commands defined in DUN profile spec.

4. Once a DUN emulator received ATD*99#, DUN client performs ppp connection=
 so we forward ppp command to ppp stack. It is done by ppp server side exte=
nsion. It should be the simple command forwarding.

5. Once the PPP link over DUN is established, DUN client performs ConnMan i=
ntegration and setup IP address, DNS server, etc.

6. Once the Bluetooth link is disconnected, we destroy the PPP and DUN emul=
ator. If emulator atom itself is destroyed, we destroy the PPP and the Blue=
tooth connection. If the PPP link is disconnected but Bluetooth link is ali=
ve, we destroy the PPP and stay emulator alive.

Comments are welcome. :)

Regards,
Zhenhua
=20

--===============3597226671035032692==--

