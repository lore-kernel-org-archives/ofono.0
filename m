Content-Type: multipart/mixed; boundary="===============9220837766254276818=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH] isigen: increase offline timeout
Date: Wed, 03 Nov 2010 20:52:57 +0200
Message-ID: <1288810377.10533.184.camel@tucson>
In-Reply-To: <AANLkTikpTANKVM6aBZpXAmjp82hthZAn6xN7fXJbuhFp@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9220837766254276818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On Wed, 2010-11-03 at 19:30 +0100, ext Pekka Pessi wrote:
> > are you sure you just wanna hardcode it like this and not use a proper
> > constant for it?
> =

> I'm not sure. It might depend on modem. Aki?

Let's go with a proper constant, and make it sufficiently large. If it
turns out this is a modem dependant property, then we will have to
device some mechanism to tweak the timeouts used by drivers from modem
plugins.

Cheers,
Aki


--===============9220837766254276818==--

