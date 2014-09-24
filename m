Content-Type: multipart/mixed; boundary="===============4355642288948581854=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem with oFono on pandaboard
Date: Wed, 24 Sep 2014 10:59:24 -0500
Message-ID: <5422EA5C.9030801@gmail.com>
In-Reply-To: <5422A3D1.9000807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4355642288948581854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Stephan,

On 09/24/2014 05:58 AM, Stephan Schmolke wrote:
> Dear oFono-Team,
>
> I have issues using oFono on my PandaBoard running ubuntu. I had to
> compile ofono from source, because I needed the bluez4 plugin
> (configure-option --enable-bluez4) and got it running on my x86 machine
> running ubuntu 13. My Programm is working fine on it.
> After Setting it up the same way on the pandaboard and checking D-Bus
> debug Messages related to oFono I figured that directly after the
> ModemAdded Signal, and getting the Modems properties the ModemRemoved
> Signal ist send. I think that might be the reason, why my Programm does
> not work. After that Signal, invoking methods on the modem Interface
> will not work anymore and time out. What could be the reason that the
> modem is almost instantly removed again?
>

You would need to look / provide debug trace or even look into BlueZ =

debug traces.  Not enough information to help you at this point.

> I also have another question: For my iPhone 5s there are not all
> Interfaces available. Is this because the iPhone/modem for it does not
> support them oder are there some Options for configuration, so they are
> available.

I'm assuming you are using iPhone 5s over HFP.  HFP is quite limited in =

its capabilities, so only a limited subset will be provided.

Regards,
-Denis

--===============4355642288948581854==--

