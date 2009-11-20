Content-Type: multipart/mixed; boundary="===============3179963485180685867=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: Palm Pre modem plugin
Date: Fri, 20 Nov 2009 14:17:06 +0100
Message-ID: <fb249edb0911200517l69b51186i39a1374e034999a3@mail.gmail.com>
In-Reply-To: <3f617f05e6577dad60f6bde6f439783a@localhost>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3179963485180685867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2009/11/20  <morphis@gravedo.de>:
> The Problem why we do this is the following: As I and some other people
> find out,
> there is no support on the data channel (the one you use in oFono to speak
> plain AT with the modem) for unsolicited responses.
>
> So the only option is to support the binary protocol to get minimally the
> response from the modem when for example a call arrives.
>
> So my question is: How do you want to manage this with your plugin for the
> Palm Pre modem? Do you even plan to use the serial interface on the
> /dev/modemuart port?

We plan to use this port when enough is known about the protocol the
modem firmware speaks on it that it can be used reliably.  I don't
have any specification for that protocol or the current firmware
sources so I can't modify it, or the WebOS telephony daemon sources.

Personally I've looked at the binary protocol and added some of my
findings to this page:
http://www.webos-internals.org/wiki/Research_Pre_GSM_Modem_Protocol ,
for that I modified the kernel to cache all the ttyS0 communication
from the start, later communication can be inspected with strace or by
renaming the /dev node to something else and providing a pty.
Do you have a fuller description of the protocol?  It doesn't seem
there's much work on it done at webos-internals for the last couple of
weeks.

The ofono plugin is experimental, but some unsolicited responses are
available on the AT port, like incoming SMS.  I've not checked
incoming voice calls yet, outgoing calls worked fine in my test.

Regards

--===============3179963485180685867==--

