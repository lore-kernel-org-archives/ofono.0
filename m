Content-Type: multipart/mixed; boundary="===============3591799615641517732=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Sat, 04 Dec 2010 14:03:38 +0200
Message-ID: <AANLkTimjMFz1c9U3P8YKALLwdCw+0W82+nuDRb49XsS3@mail.gmail.com>
In-Reply-To: <1291420976.4795.113.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3591799615641517732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/12/4 Marcel Holtmann <marcel@holtmann.org>:
> where is this timed running? I prefer the plugin just send a D-Bus
> message to the timed directly instead of a Get/Changed API kind of
> thing.

AFAIK, timed is in system bus. However, I fail to see how you can make
this any simpler. In the end, one of the two entities has to implement
a service that the other one uses. There also needs to be some
synchronization for when the entities start up. A getter/signal API is
also what timed uses in Harmattan, but of course if you have a better
idea, I'm all ears.

Cheers,
Aki

--===============3591799615641517732==--

