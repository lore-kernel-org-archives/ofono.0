Content-Type: multipart/mixed; boundary="===============2070182779456656687=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] fix can't attach GPRS issue
Date: Thu, 02 Jun 2011 07:22:25 -0500
Message-ID: <4DE78081.9020307@gmail.com>
In-Reply-To: <0E7E5CACD8E9F248AA009C292CC772A057D32E@ALA-MBA.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2070182779456656687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 06/02/2011 10:42 PM, Zhang, Caiwen wrote:
> Hi Denis,
> =

>>>>
>>>> Can you try the attached patch and tell me if this fixes your
>> problem?
>>>>
>>>
>>> Yes, it works.
>>
>> From the log it isn't clear whether oFono eventually re-attaches
>> automatically, does that work as well?
>>
> =

> It won't re-attach automatically. Following are the log from line 6792 to
> 6802 and my comment.
> =

> ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 1, A807, A=
72B71\r\n
> ofonod[619]: src/gprs.c:netreg_status_changed() 1
> =

> gprs->netreg_status is 1 (NETWORK_REGISTRATION_STATUS_REGISTERED).
> =

> ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, (nu=
ll)(null)
> ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 1
> =

> gprs->driver_attached is set to TURE. From now on, unless the modem unreg=
istered,
> gprs_netreg_update() will always return before execute gprs->driver->set_=
attached()
> because (gprs->driver_attached =3D=3D attach).

So to me it doesn't look like your interpretation is correct:

At line 6754:

ofonod[619]: PCUI: > AT+CGATT=3D1\r
ofonod[619]: PCUI: < \r\nOK\r\n
ofonod[619]: src/gprs.c:gprs_attach_callback() /huawei0 error =3D 0

This is issued in the initial gprs_netreg_update called from netreg_watch.

Then we issue a CGREG query from gprs_attach_callback@line 6768:

ofonod[619]: PCUI: > AT+CGREG?\r
ofonod[619]: PCUI: < \r\n+CGREG: 2,1, A807, 2B71\r\n\r\nOK\r\n

So driver_attached is TRUE here

At line 6778 the modem has a nervous tick:
ofonod[619]: PCUI: < \r\n^SRVST:1\r\n\r\n+CREG: 2\r\n\r\n+CGREG:
2\r\n\r\n^SRVST:2\r\n\r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 0\r\n

And the first CREG: 2 causes us to issue another gprs_netreg_update
which issues a detach@line 6797:

ofonod[619]: PCUI: > AT+CGATT=3D0\r
ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG:
0\r\n\r\nOK\r\n

The subsequent CGREG should simply update our Attached attribute to
False.  The next CREG will trigger another gprs_netreg_update, which
should in turn set the RECHECK flag to TRUE. And the subsequent CGREG
has no effect.

With my earlier patch, you should not have any changes to
driver_attached until the CGATT=3D0 returns, which should trigger another
CGREG update and assuming the RECHECK flag was set, another call to
gprs_update_netreg.

Can you investigate why this isn't happening?  Instrumentation of the
settings of driver_attached and flags would be helpful.

> =

> ofonod[619]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[619]: PCUI: > AT+CGATT=3D0\r
> ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 0\r\n\r\nO=
K\r\n
> ofonod[619]: src/gprs.c:netreg_status_changed() 1
> ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, (nu=
ll)(null)
> ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 0
> ofonod[619]: src/gprs.c:gprs_attach_callback() /huawei0 error =3D 0
> =

> gprs->driver_attached is used to indicated (CGATT) status, its value shou=
ldn't be changed before =

> gprs->driver->set_attached() execute completely.
> In this case, its value happen to be changed during gprs->driver->set_att=
ached() is executed. So
> its value is not the same as (CGATT) status. =


The value of driver_attached is not about the current CGATT status, but
the pending status of set_attached to the driver.  While related, they
are not the same.

Regards,
-Denis

--===============2070182779456656687==--

