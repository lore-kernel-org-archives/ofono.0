Content-Type: multipart/mixed; boundary="===============7408944090566394330=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 4/6] src/modem: notify lte driver before going online
Date: Fri, 12 Oct 2018 05:04:28 +0200
Message-ID: <CAKSBH7GmbNCQFxG21gEi9Mw7HSicib8W3nNq2toq9QtFWrnmJA@mail.gmail.com>
In-Reply-To: <8966c3c6-2a82-c0ae-bb59-6acb93bbd3c8@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7408944090566394330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 11, 2018 at 10:19 PM Jonas Bonn <jonas@southpole.se> wrote:
>
>
>
> On 10/10/18 08:54, Giacinto Cifelli wrote:
> > ---
> >   src/modem.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/src/modem.c b/src/modem.c
> > index 9e254482..74dbe7ad 100644
> > --- a/src/modem.c
> > +++ b/src/modem.c
> > @@ -729,6 +729,8 @@ static void sim_state_watch(enum ofono_sim_state ne=
w_state, void *user)
> >       case OFONO_SIM_STATE_READY:
> >               modem_change_state(modem, MODEM_STATE_OFFLINE);
> >
> > +             ofono_lte_set_reg_info(modem);
> > +
>
> modem_change_state(...OFFLINE) results in the post_sim() implementation
> being called.  The drivers that implement the lte atom all call
> ofono_lte_create() there.
>
> Your .._set_reg_info function checks for the existence of the atom and
> does some work.  As such, why not just merge the contents of
> ofono_lte_set_reg_info() into the at_lte_probe function instead... from
> there, it's more obvious what's going on.

The point is that the function must be called before set_online
(following), and not after post_sim, even if they happen to be
together.
This is how it works for gprs-context: before activating the context,
apn and auth are set.

It isn't so obvious to me that the probe function does the work. It is
in general the first one to be called, then there is a chance to set
the properties one by one, and eventually they are transferred to the
modem.

>
> /Jonas
>
>
> >               /* Modem is always online, proceed to online state. */
> >               if (modem_is_always_online(modem) =3D=3D TRUE)
> >                       set_online(modem, TRUE);
>

Giacinto

--===============7408944090566394330==--

