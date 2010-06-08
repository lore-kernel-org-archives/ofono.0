Content-Type: multipart/mixed; boundary="===============7536079469908014552=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [RFC patches 12/13] SMS: introduce message ID API
Date: Tue, 08 Jun 2010 22:12:59 +0000
Message-ID: <1276035445.2478.53.camel@localhost.localdomain>
In-Reply-To: <1275056848.4706.81.camel@aeonflux.t-mobile.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7536079469908014552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-05-28 at 07:27 -0700, Marcel Holtmann wrote: =

> Hi Inaky,
> =

> > +/**
> > + * Create a random UUID
> > + *
> > + * \param msg_id Descriptor
> > + *
> > + * \internal
> > + *
> > + * Crams the msg_id ID buffer with random 32-bit numbers; because we
> > + * use a byte based buffer, we play the cast to guint32 trick (as that
> > + * is what g_random_int() returns).
> > + */
> =

> can we just stick with gtk-doc like you had in your previous patches. I
> think intermixing it with doxygen is a bad idea.

Yep, my bad, sorry.

In any case, picking this up from earlier:

I have my doubts on gtk-doc vs doxygen. I remember there was a thread
somewhere (email? irc? voice?) on which system to settle on which never
got finalized. I am not too satisfied with gtk-doc's limitations, I'd
rather do doxygen. Does anyone have any preference on once vs the other?

In any case, when we settle on one, I'll have to go and cleanup all
these to conform to it. I'll also write a quick summary with examples on
how to use it in doc/.



--===============7536079469908014552==--

