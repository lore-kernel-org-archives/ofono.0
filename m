Content-Type: multipart/mixed; boundary="===============6323753777775204862=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 0/6] PPP Patches v3
Date: Tue, 23 Mar 2010 11:26:17 -0700
Message-ID: <20100323112617.169cded4@kcaccard-MOBL3>
In-Reply-To: <1269366960.11714.78.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6323753777775204862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Mar 2010 10:56:00 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Kristen,
> =

> > > And there was another problem with one variable being
> > > guint16, but the is_option casts it back to guint8. We can't really h=
ave
> > > that. Once you start casting on that scale the compiler will not warn
> > > you about type mismatches or if the value of argument is too big for =
its
> > > type.
> > =

> > Can you please let me know which git commit this fix you made was?  I =

> > want to review it because all of the option types should only be a byte
> > anyway, so I am trying to figure out if there was a mistake somewhere =

> > where we were using is_option to examine a 16 bit value.  I searched
> > through the git log and can't figure out where this change was.  I
> > can see where you changed the option type we are comparing to a regular
> > guint to avoid compiler problems, but not the other issue you mentioned.
> =

> I had a second look at these. It is the is_proto_handler actually and
> not the is_option. However that thing applies here. A helper function to
> find that handle would be better then manually coding g_list_find_custom
> in the functions.
> =

> Regards
> =

> Marcel
> =

> =


so is_proto_handler was casting a 16 bit value to an 8 bit value?  Or are y=
ou
just complaining about having g_list_find_custom in the routines.  It would
really be easier on me to understand what you are trying to tell me if you
you posted your patches to the list next time.

--===============6323753777775204862==--

