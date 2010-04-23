Content-Type: multipart/mixed; boundary="===============6567100311253958751=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC][PATCH] Add: online method to isimodem
Date: Fri, 23 Apr 2010 10:18:36 -0500
Message-ID: <201004231018.36913.denkenz@gmail.com>
In-Reply-To: <l2g80fd4e751004230646xbc33ebaaxe9f7e8242f03662f@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6567100311253958751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> >> +void ofono_modem_set_online(struct ofono_modem *modem, ofono_bool_t
> >
> > This is assuming the driver can set online states outside of oFono
> > control. Tell me a use case where this makes sense please.  If this is
> > meant to be used only by ofono core, then this function should not be
> > declared here.
> =

> I'm not assuming only core being able to drive the online state. If
> you are using a PC with an external handset as modem, it will have its
> own flight mode settings.

We've had this argument many times before, the bottom line is oFono is not =

setup to share the modem with another stack.  oFono caches results of just =

about every setting on the modem, including call settings, call barring, ca=
ll =

forwarding, sms, cell broadcast, etc, etc, etc.  Just because you can make =
it =

work for the online state doesn't mean you will ever get this right in the =

general case.

This usecase is the realm of Gammu or Gnokii, not oFono.

> >> +     ofono_dbus_dict_append(&dict, "Online", DBUS_TYPE_BOOLEAN,
> >> +                             &modem->online);
> >
> > I think FlightMode will be more recognizable for the UI guys.
> =

> It depends. Our UI people want to use "Offline" and "Online" in UI
> (while the values used in D-Bus are "flight" and "normal"). It is
> probably because they have plenty of use cases for "Offline" outside
> aeroplanes.
> =

> ...

I'm fine with either actually, maybe others have a stronger preference they=
'd =

like to argue for or against...

> > There's also the question of who stores the FlightMode user setting, and
> > whether we store it by device ID or IMSI.
> =

> Unless we provide multiple settings, it is best left to some
> application. Using my favourite phone as an example, the N900
> application controlling the modem keeps track of Call UI state and two
> UI settings, system mode (Online/offline, or if you prefer,
> normal/flight) and cellular enable/disable. Only if Call UI is ready,
> system mode is online and cellular radio is enabled, it will let modem
> out of flight mode.

I'm fine with an external entity controlling this, as we do the same for th=
e =

Powered setting.  However this means that by default oFono (and assuming =

offline/online is supported) should only get as far as offline state.  Onli=
ne =

state has to be enabled by someone else.

Lets make sure there are no other concerns here, particularly from our =

connection management guys.

Regards,
-Denis

--===============6567100311253958751==--

