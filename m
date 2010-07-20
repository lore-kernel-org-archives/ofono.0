Content-Type: multipart/mixed; boundary="===============1903245839026719661=="
MIME-Version: 1.0
From: Hemant-vilas RAMDASI <hemant.ramdasi@stericsson.com>
Subject: RE: PIPE use in ofono
Date: Tue, 20 Jul 2010 13:33:51 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C10579169FAB466E@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <2a6a6e43b9194891123a9ece20f09357@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1903245839026719661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Today's Phonet stack in 2.6.24, gprs interface looks like virtual interface=
 (similar to TUN) where no connection with real hardware is possible. =

I can't understand how peps (one on modem and other on linux phonet stack) =
are connected, so that IP packets coming from nokia modem can be forwarded =
to IP stack directly instead of routing from user space using sequence sock=
et. =

Is it possible with today's phonet stack? Is there a need of third entity l=
ike controller to do this?

Thanks,
Hvr

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of R=C3=A9mi Denis-Courmont
Sent: Tuesday, July 20, 2010 1:26 PM
To: ofono(a)ofono.org
Subject: Re: PIPE use in ofono


On Tue, 20 Jul 2010 09:22:04 +0200, Hemant-vilas RAMDASI
<hemant.ramdasi@stericsson.com> wrote:
> Is pipe/pep concept in ISI  modem, specific to a modem inside N900? Or is
> it generic to any Nokia modem?

It should be available in any Nokia modem that exposes the USB CDC Phonet
vendor-specific interface. If I recall correctly, it worked with my Nokia
N95.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============1903245839026719661==--

