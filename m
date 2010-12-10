Content-Type: multipart/mixed; boundary="===============4177078388899846040=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/5] Call Counters (2nd)
Date: Fri, 10 Dec 2010 19:34:47 +0100
Message-ID: <1292006087.30085.25.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <201012101957.51512.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4177078388899846040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > Personally I think the every-10sec interval is too short.
> > > It's also highly system specific when wakeups start to get
> > > too costly, so picking up one value seems difficult.
> > =

> > My take here is that a granularity of 1 minute is enough.
> =

> There are definitely call fares with sub-minute granularity. The minute i=
s =

> definitely INSUFFICIENT.

let me repeat my question here. Does this suppose to be represent spent
time on calls (what I called talk time) or actual billing minutes.

If we talk about correct billing minutes then you are just opening
pandora's box. Since we don't know the billing. And difference between
air time, incoming/outgoing calls, multiparty calls, hold calls etc. and
their billing schemes make this just insane.

So what is the actual requirement here. So far ever single answer was
not satisfying. And that is why I proposed to just make this count the
talk time.

> > Doing this every 10 seconds and displaying it on a per second level
> > sounds insane to me.
> =

> So I made a lengthy call to my mum this morning, using a desk phone. And =
it =

> was showing minute:second, not just minutes. I have never seen a phone th=
at =

> does not show seconds and it would look pretty dumb to me.

You do realize that this is NOT the feature we are talking about here.

The actual display of the duration of a call is pretty simple and
currently easy to handle inside the UI. And that can be done up to the
millisecond display if you or your UI designer wants it.

The proposed call counters here are long term counters showing your
overall time. So showing minutes seems to be precise enough.

Regards

Marcel



--===============4177078388899846040==--

