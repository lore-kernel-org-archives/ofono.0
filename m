Content-Type: multipart/mixed; boundary="===============5206127710815084620=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Tue, 21 Dec 2010 08:25:15 -0800
Message-ID: <1292948715.2658.58.camel@aeonflux>
In-Reply-To: <AANLkTimQrZf18yYMcwUiYV1Akr+rBChX_tatW9CKajhB@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5206127710815084620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > I am still saying that the plugin should monitor the presence of timed
> > and then just send a D-Bus message to timed. That saves us the problem
> > with the timestamping.
> =

> There is no problem. If you still think there is a problem, you need
> to continue the previous thread on this subject and prove your point.
> =

> > And in case timed is not running it should just
> > set the current time directly.
> =

> You're welcome to write such a plugin -- this is why nettime is a
> plugin API after all. It might make sense in some platforms,
> especially those that don't have a working monotonic clock...

true, but as long as you guys are proposing an official org.ofono API it
has to fit in a general context of oFono.

> > I really prefer that we don't hand out timestamps over the D-Bus API.
> > That seems wrong to me.
> =

> No timestamp is sent. Please read the patches.

So that got fixed. Is this really enough for you guys to just normalize
the value that you are getting?

Regards

Marcel



--===============5206127710815084620==--

