Content-Type: multipart/mixed; boundary="===============3313569378423772163=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Thu, 20 Sep 2018 12:18:51 -0500
Message-ID: <46d7e1eb-dd42-75ca-e5ef-d36d1d2cb8bc@gmail.com>
In-Reply-To: <CAKSBH7HG2AD4J9_AGGyTHFd-Nu2ennemZkyF+KFr2Ko=tqkN2A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3313569378423772163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/20/2018 12:03 PM, Giacinto Cifelli wrote:
> hi Denis,
> =

> On Thu, 20 Sep 2018, 18:31 Denis Kenzior, <denkenz@gmail.com =

> <mailto:denkenz@gmail.com>> wrote:
> =

>     Hi Giacinto,
> =

>      > The idea would be to just store the values in the driver but not
>     in the
>      > module,
>      > and then send them before attaching, so that the verification can =
be
>      > consistent and all,
>      > just like for the gprs-context atom.
> =

>     Yes, but that is not what you outlined in the code.=C2=A0 You were wa=
tching
>     for SIM_STATE_READY which only means just that.
> =

>     Also note that we can bring the modem online even in pre_sim state
>     (e.g.
>     for emergency calls), in which case the lte atom doesn't exist yet.
> =

> =

> where should a hook be placed then?
> this looked to me a good place, just before bringing it online.
> if there is no atom, no config and everything is ok anyway.

That's kind of the problem, there is no good place.  The only thing you =

can do is have the core apply settings, if available, just prior to the =

set_online driver call.  However, it is tricky to do so:

- We're in pre-sim state and go online for emergency calls.  This is =

okay as no LTE atom is created.  If a SIM is initialized / inserted at =

this point, the modem can re-connect with a proper default settings. =

The LTE atom creation and modem performing a re-connect is now a race. =

Admittedly the solution we have today also suffers from this problem, so =

maybe there's not much we can do here.

- We're offline and going online.  You need to perform the online =

operation as a transaction.  First setting the default attach details =

and then actually setting the modem online.  We can't do it =

simultaneously, as again we cannot assume the multiplexing / queueing =

behavior of the driver.  This could perhaps be made to work, but there =

may be additional issues that are discovered as we go along.  Only way =

to find out is to prototype it.

> =

>      >
>      > so the idea would be to check if a new method, that I have
>     tentatively
>      > called set_property(),
>      > exists. If so, use the reviewed stile above, otherwise fallback
>     to the
>      > current function.
>      >
> =

>     I don't see what set_property is buying you.=C2=A0 Anyway, feel free =
to come
>     up with a more detailed proposal, but my impression is that this
>     approach will quickly become way too complicated.
> =

> =

> I think now i got you. The existing function could be used, but the =

> driver only stores the values internally because it knows it will ve =

> called later for sending the commands.
> =


Or we simply cache the values in the lte atom and call the driver method =

only when appropriate.

Regards,
-Denis

--===============3313569378423772163==--

