Content-Type: multipart/mixed; boundary="===============5833976230976589260=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.uklinux.net>
Subject: Re: Voice call audio routing
Date: Thu, 16 Dec 2010 02:15:37 +0000
Message-ID: <871v5icvjq.fsf@ossau.uklinux.net>
In-Reply-To: <AANLkTimupnMBwpoZAM1+mmTPaojOewv4+mJTCYeiWJzt@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5833976230976589260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Nicola Mfb <nicola.mfb@gmail.com> writes:

> While testing an e169 huawei card I was able to make voice calls and
> hear something with aplay and /dev/ttyUSB1.
> On the openmoko/freerunner is a matter of HW switches, on the n900
> IIRC is done with pulseaudio.
> I guess that voice call audio routing is not in oFono plans, if I'm
> correct is there a reference project (may be not depending deeply on
> meego) that abstracts that task in an extensible/pluggable way?

Have you read "design.txt" in telepathy-ring's repository?  I think it
touches on this subject.  From my limited (so far) understanding of that
file, I think you are right that ofono does not manage the audio routing
itself.

Regards,
          Neil

--===============5833976230976589260==--

