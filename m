Content-Type: multipart/mixed; boundary="===============4591308448095380151=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Weird Droid 4 modem protocol and a way to support it
Date: Wed, 10 Jun 2020 14:30:55 -0500
Message-ID: <33a01f94-86e0-3b2f-9d82-b3140dd1261c@gmail.com>
In-Reply-To: <20200610140042.GW43721@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4591308448095380151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

<snip>

> =

> All we need to do with the TS 27.010 packets is parse the network
> strength, operate the voice modem, ack SMS notifications, and pass all
> the other notifications to the qmimodem to deal with over USB.
> =

> To me it seems ideal would be simple read/write type functions in
> drivers/motorolamodem. Is there some preferred existing exaple for
> doing something like that?

Not sure I understand.  Example of using ell?  See drivers/mbimmodem/*.

Regards,
-Denis

--===============4591308448095380151==--

