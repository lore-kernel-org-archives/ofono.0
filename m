Content-Type: multipart/mixed; boundary="===============3976134333279040529=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC patches 12/13] SMS: introduce message ID API
Date: Tue, 08 Jun 2010 16:14:37 -0700
Message-ID: <1276038877.2182.56.camel@localhost.localdomain>
In-Reply-To: <1276035445.2478.53.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3976134333279040529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> > > +/**
> > > + * Create a random UUID
> > > + *
> > > + * \param msg_id Descriptor
> > > + *
> > > + * \internal
> > > + *
> > > + * Crams the msg_id ID buffer with random 32-bit numbers; because we
> > > + * use a byte based buffer, we play the cast to guint32 trick (as th=
at
> > > + * is what g_random_int() returns).
> > > + */
> > =

> > can we just stick with gtk-doc like you had in your previous patches. I
> > think intermixing it with doxygen is a bad idea.
> =

> Yep, my bad, sorry.
> =

> In any case, picking this up from earlier:
> =

> I have my doubts on gtk-doc vs doxygen. I remember there was a thread
> somewhere (email? irc? voice?) on which system to settle on which never
> got finalized. I am not too satisfied with gtk-doc's limitations, I'd
> rather do doxygen. Does anyone have any preference on once vs the other?
> =

> In any case, when we settle on one, I'll have to go and cleanup all
> these to conform to it. I'll also write a quick summary with examples on
> how to use it in doc/.

my preference with gtk-doc is that it generates nicer documentation and
also makes devhelp files available.

Regards

Marcel



--===============3976134333279040529==--

