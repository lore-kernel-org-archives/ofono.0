Content-Type: multipart/mixed; boundary="===============5486305442624596157=="
MIME-Version: 1.0
From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: Some experiments with the SIMCOM SIM5216E modem on a ARM926 board
Date: Fri, 13 Jan 2012 05:54:56 +0100
Message-ID: <4F0FB920.8040309@eclis.ch>
In-Reply-To: <1326426691.6454.255.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5486305442624596157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> So lets figure out which one is the NMEA port and which one is the
> QCDM/DIAG port. Use gatchat/test-qcdm --device<tty>  and see which one
> responds. That one is the QCDM port and the other is the NMEA port.

As expected, now that we known the mapping:

$ test-qcdm --device /dev/ttyUSB0
Device: /dev/ttyUSB0
=3D=3D> Version information
Compiled Date: Nov 25 2010
Compiled Time: 10:41:31
Release Date: Jun 21 2010
Release Time: 01:00:00
Model: KPUBL
MSM version: 1
=3D=3D> Features response
=3D=3D> Invalid command response

Others interfaces don't response, as expected.

By the way, I just discover this test-qcdm utility. SIMCOM is currently =

evaluating the possibility to provide to me some additional hardware to =

investigate the AT+CLCC issue as there can't reproduce it on there side. =

As far as understand, this would consist precisely in a software =

connected to the diagnostic port. Did you think that test-qcdm is good =

enough for the task ?

> I bet that interface #4 is actually some form of CDC Ethernet for
> highspeed data transfers. So that you do not have to use PPP. Might
> wanna ask SIM COM about it.

Yes, would be great. I will ask them on that.

Regards,

Jean-Christian


--===============5486305442624596157==--

