Content-Type: multipart/mixed; boundary="===============1848483705226247923=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 00/16] Add modem emulator in oFono
Date: Thu, 13 May 2010 18:02:23 +0800
Message-ID: <1273744959-3711-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1848483705226247923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This serie of patches implement the framework of modem emulator in oFono. I=
t has an emulator manager to create the emulator that can be one of DUN, HF=
P or SPP type. You can power on phonesim and use 'gatchat/test-emulator' to=
 create a DUN emulator. A voicecall dialing case is included for testing pu=
rpose.

TODO:
1. Only one emulator is allowed in other atom like voicecall now. Need to s=
upport multiple emulators in each atom.
2. GPRS dial up is not implement yet. If we need to implement both legacy '=
ATD*99#' and 'AT+CGDATA', Which one has higher priority?

Please review them and feel free to let me know your comments. Thanks.



--===============1848483705226247923==--

