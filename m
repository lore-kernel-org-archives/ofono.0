Content-Type: multipart/mixed; boundary="===============9059866416500447600=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono plugin
Date: Wed, 02 Nov 2011 09:58:18 -0500
Message-ID: <4EB15A8A.7050105@gmail.com>
In-Reply-To: <4EB3DD3A.9040408@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9059866416500447600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> - DUN: ConnMan should directly talk to BlueZ. There are too many issues
> with having oFono in the middle. There is a strong relation ship between
> PAN and DUN and ConnMan needs to be aware of it. Think about the kill
> switch for bluetooth.
> =


This is not so clear cut.  The gatchat library is an ofono exclusive
right now, and putting it into BlueZ might be somewhat 'controversial'.
 The other option is of course to create a separate daemon inside the
ofono source tree...

It may be that we need to discuss how Bluetooth / PAN is modeled in
ConnMan and whether we should do the same for DUN or not first.

Regards,
-Denis

--===============9059866416500447600==--

