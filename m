Content-Type: multipart/mixed; boundary="===============2594906607287265406=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 0/2] Add Suspended property to GPRS
Date: Wed, 08 Sep 2010 16:39:21 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7BA83AF9@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1283953922.6640.32.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2594906607287265406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =


> From: ofono-bounces(a)ofono.org =

> [mailto:ofono-bounces(a)ofono.org] On Behalf Of ext Marcel Holtmann

> > The isimodem driver will currently suppress changes in the
> > property value for short-lived suspended states caused by SMS
> > transmission or other signalling. It would also be possible
> > to do the suppression in the oFono core in a generic way.
> > Alternatively, all the state changes and their reasons could
> > also be exposed to oFono clients. However, my feeling is
> > that the information might not be available in a sufficiently
> > coherent way from the different modems. Anyway, I'm open to
> > suggestions.
> =

> we had a brief discussion about this some time ago. And I don't think
> that we can do anything than give the clients (UI and ConnMan) and
> indication that the suspend has happened right now. In =

> general it is too
> late anyway. Since making a voice call and sending a SMS are decisions
> by the end user. And he/she wants to execute them right now. So it is
> expected that GPRS gets suspended.

Yes, I agree, there's no sane way to provide pre-warning. A signal that
comes after the fact still has some potential uses, though:

- a hint for internet connection management to start looking for an
  alternative access, in case GPRS is not back shortly
- a signal for mobile-aware applications to adjust their behavior
- UI notification for the end user

> I do agree that we should not blindly tell the clients suspended if we
> now that it is a short lived situation like SMS. My personal =

> preference
> here would be that this is done inside oFono core and the =

> hardware just
> signals suspend (if it actually supports such notifications).
> =

> So how much work would it take to do the delay in the core?

Not that hard, I guess. We could define a suspend cause code that gets
notified to the core, based on which the core would either modify the
property immediately or start a guard timer. Perhaps something along
the lines of:

enum gprs_suspend_status {
	GPRS_SUSPENDED_DETACHED,
	GPRS_SUSPENDED_SIGNALLING,
	GPRS_SUSPENDED_CALL,
	GPRS_SUSPENDED_NO_COVERAGE,
	GPRS_SUSPENDED_UKNOWN_CAUSE,
	GPRS_AVAILABLE,
};

src/gprs.c:
void ofono_gprs_suspend_notify(struct ofono_gprs *gprs,
				enum gprs_suspend_status status)
{
	...
}

The cause code could also be exposed in the DBus interface.

> I know, that
> the ISI modem is more sophisticated protocol, but we do have AT modems
> that have a bit harder time gathering all the information.

AT modem drivers could use any subset of the above causes.
To allow opt-in implementation in the drivers, the core could
automatically change the status between GPRS_SUSPENDED_DETACHED
and GPRS_AVAILABLE based on attach/detach notifications.

I can redraft the patches to do this. I don't really have a clue
what kind of vendor extensions are available for this in AT modems,
though. Any examples would be helpful.

Br,

	MikaL

--===============2594906607287265406==--

