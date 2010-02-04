Content-Type: multipart/mixed; boundary="===============6866558608166556444=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Add radio settings atom and driver API
Date: Thu, 04 Feb 2010 16:14:15 -0600
Message-ID: <201002041614.15909.denkenz@gmail.com>
In-Reply-To: <a32762a21002041401y57ad45abob5e5bc22bc54292@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6866558608166556444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> Hi Denis,
> =

> 2010/2/4 Denis Kenzior <denkenz@gmail.com>:
> >> +typedef void (*ofono_radio_settings_mode_query_cb_t)(const struct
> >>  ofono_error *error, +                                              =

> >>  enum ofono_radio_access_mode mode, +                                  =

> >>           void *data);
> >
> > I still say this part is not required.
> >
> >> +
> >> +struct ofono_radio_settings_driver {
> >> +     const char *name;
> >> +     int (*probe)(struct ofono_radio_settings *rs, unsigned int vendo=
r,
> >> void *data); +    void (*remove)(struct ofono_radio_settings *rs);
> >> +     void (*query_mode)(struct ofono_radio_settings *rs,
> >> +                             ofono_radio_settings_mode_query_cb_t cb,
> >> void *data);
> >
> > Neither is query_mode.  This is a local modem setting, not a network
> > setting. There's simply no reason to query it when oFono can store the
> > settings.
> =

> Even with storage, it's needed the very first time a new SIM card is
> inserted, no?
> =


Not really, we can default to a safe setting (e.g. any) if no previous sett=
ing =

has been saved.  We do this for GPRS, Cell Broadcasts, etc.

> > Lets just add ability to read the mode setting from storage and set it =
at
> > interface startup.
> =

> I can agreee to storing SIM data, but for other settings that are
> anyway saved on the modem's non-volatile memory, this seems wrong.
> oFono is aimed to be usable also on the desktop using tethering, which
> means most of the time these settings are touched on the phone.

But also remember I want to keep all my settings when I switch SIMs.  On th=
e =

desktop that is a much likelier scenario (e.g. GPRS data cards), travel =

between countries, etc. The radio access setting is likely to be specific t=
o a =

network provider (e.g. poor 3G coverage) rather than the device.

I agree tethering is a usecase we haven't considered properly yet, but =

honestly I'm not sure the PC should be messing with radio preference settin=
gs =

while tethered...

> =

> (As an aside, I have right now two N900s connected to my laptop via
> USB, and was just making calls between them using oFono and d-feet.)
> =


Nice :)

Regards,
-Denis

--===============6866558608166556444==--

