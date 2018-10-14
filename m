Content-Type: multipart/mixed; boundary="===============8185517104745762554=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH v2 2/2] plugins/gemalto: added voice support
Date: Sun, 14 Oct 2018 19:03:58 +0200
Message-ID: <CAKSBH7Fz8VqzAvCGz+jZgeyBF5-iai_s3sG=-tpmGs1-zXTJoQ@mail.gmail.com>
In-Reply-To: <53ceb48a-0e9b-898a-67fd-94a7a65073a5@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8185517104745762554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

I answer here to the point about VTS with quotes.

On Sun, Oct 14, 2018 at 6:50 PM Jonas Bonn <jonas@southpole.se> wrote:
>
>
>
> On 14/10/18 16:17, Giacinto Cifelli wrote:
> > The plugin for Gemalto modems is enriched with all voice-related atoms,
> > as well as USSD.
> > All except the voicecall itself are from the atmodem, while the
> > voicecall is from gemaltomodem.
> > ---
> >   plugins/gemalto.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> > index 0fcf30d8..8a965748 100644
> > --- a/plugins/gemalto.c
> > +++ b/plugins/gemalto.c
> > @@ -571,6 +571,10 @@ static void gemalto_pre_sim(struct ofono_modem *mo=
dem)
> >
> >       ofono_devinfo_create(modem, 0, "atmodem", data->app);
> >       ofono_location_reporting_create(modem, 0, "gemaltomodem", data->a=
pp);
> > +
> > +     ofono_modem_set_integer(modem, "GemaltoVtsQuotes", 1);
>
> Do you really mean to set this unconditionally for all models?

The current supported modules for the gemalto plugin, and also TC65
for the cinterion plugin, require quotes.
But not the EHS6.
I need to add quite a few modules in the gemalto plugin, but for now
there are still too many patches to push before.
So for now, it is fixed, but later it will depend on the model.
I won't be patching the cinterion plugin, because I have the
impression it is not used anymore.
Several things don't work anymore as they were when this was implemented.
I intend, however, to merge it with the gemalto one, and then I will
take care of it.
Most Gemalto modules can work over USB or RS232, so it still makes
sense to maintain the serial interface.

>
> /Jonas
>

Giacinto

--===============8185517104745762554==--

