Content-Type: multipart/mixed; boundary="===============4743685860896920316=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [SMS D-Bus 02/19] sms: introduce message ID API
Date: Thu, 05 Aug 2010 11:07:10 -0700
Message-ID: <1281031630.19261.98.camel@localhost.localdomain>
In-Reply-To: <4C5AFCB1.1000901@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4743685860896920316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-08-05 at 13:02 -0500, Denis Kenzior wrote: =

> Hi Inaky,
> =

> >> The current message id is 32 bits.  Why are we stopping at 16?  We cou=
ld
> >> go all the way to 64 if needed...
> > =

> > Well, at the end what gets sent to the network is 16 bits right?
> =

> So I think we're all confused here.  This ID is not being sent to the
> network.  It is only used for uniquely identifying the message over
> D-Bus and to message history.  This number can be as small or as big as
> we want.

I was under the impression that you wanted to use this for the ref also,
and thus it is imprinted into the PDUs by set_ref_and_to(). Can you
confirm this?

> >> Also, we need to take time and some random value into account.  Perhaps
> >> including time() output and a simple static counter into the hashing
> >> function would make it unique for those 'same sender, same contents
> >> messages'
> > =

> > So then we really don't care about being able to regenerate the hash ID
> > from the contents?
> > =

> > The design discussions we held about this involved being able to, with
> > the content of the message and destination number, generating a hash
> > that could be uniquely reproduced by rehashing it again. You had a
> > reason for it and I can't remember which one it was -- I should have
> > written it down. But that brought the problem of 'somebody sending the
> > same message to the same number' which yields the same ID.
> > =

> > However, if to fix that we are adding randomness in the form of time(),
> > why bother with the contents? let's just do a random ID from the ground
> > up and save us the pain of hashing.
> > =

> =

> I don't remember this discussion any more.  There might be a case where
> an old message is re-delivered because oFono crashed after delivery but
> before deletion.
> =

> At least to me it seems that generating a random int is really not
> guaranteed to be unique over reboots.  Hashing seems way better.
> However, I'm not a math/crypto geek, so feel free to prove me wrong.

Ok, I see your concern. Proper seeding of the RNG should take care of
that case, but either way works. If you want hashing + time() seeding
that can be done easily.

I still could use clarification on which other fields of the 'struct
sms' union you want to have hashed other than the PDU payloads.


--===============4743685860896920316==--

