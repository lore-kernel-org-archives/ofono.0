Content-Type: multipart/mixed; boundary="===============0806323058912791540=="
MIME-Version: 1.0
From: Max <Max.Suraev@fairwaves.ru>
Subject: Re: scan problem
Date: Fri, 20 Apr 2012 16:59:49 +0800
Message-ID: <4F912585.3050709@fairwaves.ru>
In-Reply-To: <ED4DEEB78293B34A9D0EAC02A474A46E18AA289A@IRSMSX102.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0806323058912791540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OFONO_AT_DEBUG=3D1 ./src/ofonod -n -d plugins/*

ofonod[22144]: oFono version 1.5
ofonod[22144]: Reading of /etc/ofono/phonesim.conf failed: No such file or =
directory
ofonod[22144]: > AT+GCAP\r
__________________________
That's what I've after ./enable-modem /wavecom_q_0
./online-modem /wavecom_q_0 produces no additional output from ofonod.

Please advice how can I gather more info to debug this issue.

thanks,
Max.


--===============0806323058912791540==--

