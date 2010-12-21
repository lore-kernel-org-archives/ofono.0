Content-Type: multipart/mixed; boundary="===============8198242233877954949=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Tue, 21 Dec 2010 17:54:53 +0200
Message-ID: <AANLkTimQrZf18yYMcwUiYV1Akr+rBChX_tatW9CKajhB@mail.gmail.com>
In-Reply-To: <1292941064.2658.29.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8198242233877954949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/12/21 Marcel Holtmann <marcel@holtmann.org>:
> I am still saying that the plugin should monitor the presence of timed
> and then just send a D-Bus message to timed. That saves us the problem
> with the timestamping.

There is no problem. If you still think there is a problem, you need
to continue the previous thread on this subject and prove your point.

> And in case timed is not running it should just
> set the current time directly.

You're welcome to write such a plugin -- this is why nettime is a
plugin API after all. It might make sense in some platforms,
especially those that don't have a working monotonic clock...

> I really prefer that we don't hand out timestamps over the D-Bus API.
> That seems wrong to me.

No timestamp is sent. Please read the patches.

Cheers,
Aki

--===============8198242233877954949==--

