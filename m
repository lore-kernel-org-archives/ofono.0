Content-Type: multipart/mixed; boundary="===============8469062773427211058=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: [PATCH v2] fix can't attach GPRS issue
Date: Fri, 03 Jun 2011 03:42:00 +0000
Message-ID: <0E7E5CACD8E9F248AA009C292CC772A057D32E@ALA-MBA.corp.ad.wrs.com>
In-Reply-To: <4DE75421.6040907@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8469062773427211058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >>
> >> Can you try the attached patch and tell me if this fixes your
> problem?
> >>
> >
> > Yes, it works.
> =

> From the log it isn't clear whether oFono eventually re-attaches
> automatically, does that work as well?
> =


It won't re-attach automatically. Following are the log from line 6792 to
6802 and my comment.

ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 1, A807, A72=
B71\r\n
ofonod[619]: src/gprs.c:netreg_status_changed() 1

gprs->netreg_status is 1 (NETWORK_REGISTRATION_STATUS_REGISTERED).

ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, (null=
)(null)
ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 1

gprs->driver_attached is set to TURE. From now on, unless the modem unregis=
tered,
gprs_netreg_update() will always return before execute gprs->driver->set_at=
tached()
because (gprs->driver_attached =3D=3D attach).

ofonod[619]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[619]: PCUI: > AT+CGATT=3D0\r
ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 0\r\n\r\nOK\=
r\n
ofonod[619]: src/gprs.c:netreg_status_changed() 1
ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, (null=
)(null)
ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 0
ofonod[619]: src/gprs.c:gprs_attach_callback() /huawei0 error =3D 0

gprs->driver_attached is used to indicated (CGATT) status, its value should=
n't be changed before =

gprs->driver->set_attached() execute completely.
In this case, its value happen to be changed during gprs->driver->set_attac=
hed() is executed. So
its value is not the same as (CGATT) status. =


best regards
Caiwen


--===============8469062773427211058==--

