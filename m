Content-Type: multipart/mixed; boundary="===============3566499585679840988=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 0/2] Add Suspended property to GPRS
Date: Wed, 08 Sep 2010 16:58:10 +0200
Message-ID: <1283957890.6640.50.camel@localhost.localdomain>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A7BA83AF9@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3566499585679840988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> > > The isimodem driver will currently suppress changes in the
> > > property value for short-lived suspended states caused by SMS
> > > transmission or other signalling. It would also be possible
> > > to do the suppression in the oFono core in a generic way.
> > > Alternatively, all the state changes and their reasons could
> > > also be exposed to oFono clients. However, my feeling is
> > > that the information might not be available in a sufficiently
> > > coherent way from the different modems. Anyway, I'm open to
> > > suggestions.
> > =

> > we had a brief discussion about this some time ago. And I don't think
> > that we can do anything than give the clients (UI and ConnMan) and
> > indication that the suspend has happened right now. In =

> > general it is too
> > late anyway. Since making a voice call and sending a SMS are decisions
> > by the end user. And he/she wants to execute them right now. So it is
> > expected that GPRS gets suspended.
> =

> Yes, I agree, there's no sane way to provide pre-warning. A signal that
> comes after the fact still has some potential uses, though:
> =

> - a hint for internet connection management to start looking for an
>   alternative access, in case GPRS is not back shortly
> - a signal for mobile-aware applications to adjust their behavior
> - UI notification for the end user

That is basically what we had in mind. If the UI wants to show a warning
or change it icon. It can do this with the property changed signal. And
it only does this when there is an interaction that takes longer.

And ConnMan can decide to fallback to some other connection or needs to
tell the application that their connection is stalled now.

We have something similar with MMS where the hardware or network only
supports one PDP context. In that case it is even worse actually since
we take the proper IP connection away and it won't come back as it was.

In the end similar enough since if you wait long enough your TCP
connections will time out.

> > I do agree that we should not blindly tell the clients suspended if we
> > now that it is a short lived situation like SMS. My personal =

> > preference
> > here would be that this is done inside oFono core and the =

> > hardware just
> > signals suspend (if it actually supports such notifications).
> > =

> > So how much work would it take to do the delay in the core?
> =

> Not that hard, I guess. We could define a suspend cause code that gets
> notified to the core, based on which the core would either modify the
> property immediately or start a guard timer. Perhaps something along
> the lines of:
> =

> enum gprs_suspend_status {
> 	GPRS_SUSPENDED_DETACHED,
> 	GPRS_SUSPENDED_SIGNALLING,
> 	GPRS_SUSPENDED_CALL,
> 	GPRS_SUSPENDED_NO_COVERAGE,
> 	GPRS_SUSPENDED_UKNOWN_CAUSE,
> 	GPRS_AVAILABLE,
> };
> =

> src/gprs.c:
> void ofono_gprs_suspend_notify(struct ofono_gprs *gprs,
> 				enum gprs_suspend_status status)
> {
> 	...
> }
> =

> The cause code could also be exposed in the DBus interface.

I wouldn't go there as exposing it over D-Bus. However telling the core
a bit more details about this would be a good idea. Then it can decide
to either delay the notification or send it right away.

I prefer to start simple first. Making it too complicated in the
beginning is a bad idea. And giving application too much information is
a bad idea anyway. They should only get what they really need. And right
now I don't see a need to tell them any more details, than the GPRS
connection is suspended. And that means we don't know when we get it
back. So deal with this situation.

Corner cases where a phone call gets hung up right away is nasty, but
that happens, but then again, the user was making a phone call in the
first place. So a user initiated choice we are trying to cope with.

However "suspend" with flag "available" sounds like a bad API. Either we
call this gprs_state or something similar or we have suspend/resume
pairs. Just to be a bit more symmetric here.

> > I know, that
> > the ISI modem is more sophisticated protocol, but we do have AT modems
> > that have a bit harder time gathering all the information.
> =

> AT modem drivers could use any subset of the above causes.
> To allow opt-in implementation in the drivers, the core could
> automatically change the status between GPRS_SUSPENDED_DETACHED
> and GPRS_AVAILABLE based on attach/detach notifications.
> =

> I can redraft the patches to do this. I don't really have a clue
> what kind of vendor extensions are available for this in AT modems,
> though. Any examples would be helpful.

I have no idea either. Denis might know.

Regards

Marcel



--===============3566499585679840988==--

