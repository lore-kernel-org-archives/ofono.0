Content-Type: multipart/mixed; boundary="===============3020698617953373836=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Thu, 27 May 2010 14:56:45 +0300
Message-ID: <1274961405.3755.505.camel@tucson.research.nokia.com>
In-Reply-To: <1274960389.4706.6.camel@aeonflux.t-mobile.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3020698617953373836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-05-27 at 13:39 +0200, ext Marcel Holtmann wrote: =

> > I don't like this being an argument to SendMessage(). I think it needs
> > to be exposed, but as a property instead. Is there a use case for
> > setting this per message? I think majority of current phones either
> > provide a global setting for this, or set it on by default.
> =

> our idea is actually that every new SMS has its own object path for its
> lifetime. So we can have then properties easily on them.

Sure, but there should still be a property in SmsManager to control
whether srr is to be set on outgoing messages.

Another property in the actual SmsMessage (residing on its own object
path) could then indicate whether srr *was* set for that particular
message when it was sent.

Cheers,
Aki


--===============3020698617953373836==--

