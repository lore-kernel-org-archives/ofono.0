Content-Type: multipart/mixed; boundary="===============7160551775772210853=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: Problems of CF setting and GSM string 
Date: Tue, 14 Jul 2009 13:13:45 +0800
Message-ID: <B94C62E7C2870743865418621F040C130203F12ABF@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7160551775772210853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI,
Test against the 0.1 version,
Tow problem were detected, =


1, only set CF no reply timer can't successful, and I have to set no reply =
number or disable it first.
   Cf.setproperties("VoiceNoReply",dbusInt16(30))

2, *SC***SIC# don't support in GSM string
   *61***30#
Are they known issue? or anything I did wrong

Also only CF need update DATA,FAX,SMS in the future, right? =


Thanks
Zhigang

--===============7160551775772210853==--

