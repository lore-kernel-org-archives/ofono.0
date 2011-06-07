Content-Type: multipart/mixed; boundary="===============4884398908040701713=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: [PATCH v2] fix can't attach GPRS issue
Date: Tue, 07 Jun 2011 07:24:28 +0000
Message-ID: <0E7E5CACD8E9F248AA009C292CC772A0755BE2@ALA-MBA.corp.ad.wrs.com>
In-Reply-To: <4DE78081.9020307@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4884398908040701713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >>>> Can you try the attached patch and tell me if this fixes your
> >> problem?
> >>>>
> >>>
> >>> Yes, it works.
> >>
> >> From the log it isn't clear whether oFono eventually re-attaches
> >> automatically, does that work as well?
> >>
> >
> > It won't re-attach automatically. Following are the log from line
> 6792 to
> > 6802 and my comment.
> >
> > ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 1,
> A807, A72B71\r\n
> > ofonod[619]: src/gprs.c:netreg_status_changed() 1
> >
> > gprs->netreg_status is 1 (NETWORK_REGISTRATION_STATUS_REGISTERED).
> >
> > ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1,
> (null)(null)
> > ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 1
> >
> > gprs->driver_attached is set to TURE. From now on, unless the modem
> unregistered,
> > gprs_netreg_update() will always return before execute gprs->driver-
> >set_attached()
> > because (gprs->driver_attached =3D=3D attach).
> =

> So to me it doesn't look like your interpretation is correct:
> =

> At line 6754:
> =

> ofonod[619]: PCUI: > AT+CGATT=3D1\r
> ofonod[619]: PCUI: < \r\nOK\r\n
> ofonod[619]: src/gprs.c:gprs_attach_callback() /huawei0 error =3D 0
> =

> This is issued in the initial gprs_netreg_update called from
> netreg_watch.
> =

> Then we issue a CGREG query from gprs_attach_callback at line 6768:
> =

> ofonod[619]: PCUI: > AT+CGREG?\r
> ofonod[619]: PCUI: < \r\n+CGREG: 2,1, A807, 2B71\r\n\r\nOK\r\n
> =

> So driver_attached is TRUE here
> =

> At line 6778 the modem has a nervous tick:
> ofonod[619]: PCUI: < \r\n^SRVST:1\r\n\r\n+CREG: 2\r\n\r\n+CGREG:
> 2\r\n\r\n^SRVST:2\r\n\r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 0\r\n
> =

> And the first CREG: 2 causes us to issue another gprs_netreg_update
> which issues a detach at line 6797:
> =

> ofonod[619]: PCUI: > AT+CGATT=3D0\r
> ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG:
> 0\r\n\r\nOK\r\n
> =

> The subsequent CGREG should simply update our Attached attribute to
> False.  The next CREG will trigger another gprs_netreg_update, which
> should in turn set the RECHECK flag to TRUE. And the subsequent CGREG
> has no effect.
> =

> With my earlier patch, you should not have any changes to
> driver_attached until the CGATT=3D0 returns, which should trigger another
> CGREG update and assuming the RECHECK flag was set, another call to
> gprs_update_netreg.
> =

> Can you investigate why this isn't happening?  Instrumentation of the
> settings of driver_attached and flags would be helpful.
> =


gprs_netreg_update() is the only place to change CGATT automatically.

Following are the code of gprs_netreg_update().

	ofono_bool_t attach;

	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTER=
ED;

	attach =3D attach || (gprs->roaming_allowed &&
		gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);

	attach =3D attach && gprs->powered;

	if (gprs->driver_attached =3D=3D attach)
		return;

As my comment above, because gprs->netreg_status is 1(NETWORK_REGISTRATION_=
STATUS_REGISTERED)
and gprs->driver_attached is TRUE. So (gprs->driver_attached =3D=3D attach)=
. This function always
return here, unless, the value of gprs->netreg_status or gprs->driver_attac=
hed is changed.

As gprs_netreg_update() always returns here, so gprs->driver_attached won't=
 be changed.
So unless the network registration status changes to unregistered then regi=
stered again,
it won't attach GPRS again.

> >
> > ofonod[619]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> > ofonod[619]: PCUI: > AT+CGATT=3D0\r
> > ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG:
> 0\r\n\r\nOK\r\n
> > ofonod[619]: src/gprs.c:netreg_status_changed() 1
> > ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1,
> (null)(null)
> > ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 0
> > ofonod[619]: src/gprs.c:gprs_attach_callback() /huawei0 error =3D 0
> >
> > gprs->driver_attached is used to indicated (CGATT) status, its value
> shouldn't be changed before
> > gprs->driver->set_attached() execute completely.
> > In this case, its value happen to be changed during gprs->driver-
> >set_attached() is executed. So
> > its value is not the same as (CGATT) status.
> =

> The value of driver_attached is not about the current CGATT status, but
> the pending status of set_attached to the driver.  While related, they
> are not the same.
> =


best regards
Caiwen

--===============4884398908040701713==--

