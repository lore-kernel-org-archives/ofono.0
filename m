Content-Type: multipart/mixed; boundary="===============3033436497870074749=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Voice call audio routing
Date: Thu, 16 Dec 2010 11:49:46 +0100
Message-ID: <1292496586.30085.87.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <AANLkTimupnMBwpoZAM1+mmTPaojOewv4+mJTCYeiWJzt@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3033436497870074749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

> While testing an e169 huawei card I was able to make voice calls and
> hear something with aplay and /dev/ttyUSB1.
> On the openmoko/freerunner is a matter of HW switches, on the n900
> IIRC is done with pulseaudio.
> I guess that voice call audio routing is not in oFono plans, if I'm
> correct is there a reference project (may be not depending deeply on
> meego) that abstracts that task in an extensible/pluggable way?

check tools/huawei-audio.c for a really simple example of the audio
processing.

Regards

Marcel



--===============3033436497870074749==--

