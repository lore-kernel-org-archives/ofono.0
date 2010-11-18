Content-Type: multipart/mixed; boundary="===============0162006723298509356=="
MIME-Version: 1.0
From: Benis, Robertino <robertino.benis@intel.com>
Subject: RE: [PATCH] ifxmodem: Adding fast dormancy support to Infineon modem
Date: Wed, 17 Nov 2010 22:15:20 -0800
Message-ID: <CB28AA307186A940B1253A743EA1F20AA60D6C5B@orsmsx507.amr.corp.intel.com>
In-Reply-To: <1290052063.29148.15.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0162006723298509356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> +	snprintf(buf, sizeof(buf), "AT+XFDOR=3D%u", rsd->fast_dormancy);

> is this command for fast dormancy really doing exactly what is expected
> according to doc/radio-settings.txt. In my last documentation from
> Infineon, that is still not the case.

According to the doc I have, modem implementation is quite close:

"Trigger Fast Dormancy +XFDOR
This command triggers fast dormancy if all conditions are passed successful=
 it will be send towards the network. There will be no confirmation if the =
request was executed or not as in the last extend the full execution belong=
s to the network."

I tested this (with couple of weeks old FW), and on AT+XFDOR=3D1 got OK bac=
k, which, I understand, doesn't mean much, since there is no other confirma=
tion, and there is no read AT command available yet, but I thought it was a=
 good start.

Thanks,
-- r.

--===============0162006723298509356==--

