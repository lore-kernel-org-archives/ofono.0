Content-Type: multipart/mixed; boundary="===============0493117432913671909=="
MIME-Version: 1.0
From: Gustavo Padovan <padovan@profusion.mobi>
Subject: Re: No audio with HFP
Date: Wed, 21 Sep 2011 18:43:29 -0300
Message-ID: <20110921214329.GA2890@joana>
In-Reply-To: <1316639986.33799.YahooMailNeo@web31811.mail.mud.yahoo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0493117432913671909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Scott,

* Scott Haynie <scottahaynie@yahoo.com> [2011-09-21 14:19:46 -0700]:

> Trying to get ofono HFP to work on my Ubuntu 11.04 box.=C2=A0 I can =

> connect to the bluetooth device and initiate a voice call, but I can't =

> hear any audio coming from the speakers.
> Went through the =

> instructions here: http://ofono.org/wiki/hands-free-profile . Saw =

> something related to configuring pulse audio, but no pointers as to how =

> to do that-- I do have the pulse audio package installed.

Have a check at
http://padovan.org/blog/2010/02/handsfree-profile-into-bluez-and-ofono/

The audio is handled by pulseaudio, and you need to enable loopback between
the Bluetooth stream and your mic and speaker.

	Gustavo

--===============0493117432913671909==--

