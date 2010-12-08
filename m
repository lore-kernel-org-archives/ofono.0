Content-Type: multipart/mixed; boundary="===============8638602323955451163=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/5] Call Counters (2nd)
Date: Wed, 08 Dec 2010 10:03:04 +0100
Message-ID: <1291798984.4795.146.camel@aeonflux>
In-Reply-To: <AANLkTim07pnimBQFXt8z43ewjPOW9GSobv8yTLJyfGmR@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8638602323955451163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > Here a proposal for call counters implementation for keeping track
> > of the total incoming and outgoing call duration counters. Each
> > established call instance is contributing to either of the call
> > duration counters. The 2 counters are updated periodically when
> > there is an established call and the information is stored in
> > a file. The bookkeeping of the call duration counters are per IMSI
> > number.
> > The implementation makes use of the history framework which had to be
> > expanded with a function for marking the beginning of a voice call.
> > There is a D-Bus interface to call counters for reading and clearing
> > the counters.
> =

> This set looks good to me, and I believe you fixed the issues from
> previous review comments. Denis, are you ok with this?

so Denis and I talked about this a little bit and I am not fine with
this at all.

Lets take this one step and please explain to me what your requirements
and objectives are. I also wanna see a top to bottom from UI down to the
modem usage of this API.

My main concerns are here that we are waking up ofonod every 10 seconds
and consuming heavy IO with writing this information to disk. In
addition to that there is no clear UI usage for the getter API.

What are the granularity there. What is the expected user experience
with this API. I don't see any clear usage model here.

In addition to that, what is the problem with just updating the stats
after the call has ended?

Are you really expecting realtime updates of call time stats for some
hidden UI stats menu? This would be a really expensive change for just
doing that.

Has anybody looked at how we are doing realtime stats inside ConnMan?

Regards

Marcel



--===============8638602323955451163==--

