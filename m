Content-Type: multipart/mixed; boundary="===============6236196144686263224=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH] atmodem: Enable network time for AT modem
Date: Tue, 08 Mar 2011 12:35:59 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802E706DD@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1299577494.23123.7.camel@apaila-ThinkPad-T410>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6236196144686263224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

ofono-bounces(a)ofono.org wrote:
> Hi Jeevaka,
> =

> On Tue, 2011-03-08 at 10:59 +0200, ext
> Jeevaka.Badrappan(a)elektrobit.com
> wrote:
>> Hi Antti,
>> =

>> ofono-bounces(a)ofono.org wrote:
>>> ---
>>>  drivers/atmodem/network-registration.c |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>> =

>>> diff --git a/drivers/atmodem/network-registration.c
>>> b/drivers/atmodem/network-registration.c
>>> index 4913611..2d589f0 100644
>>> --- a/drivers/atmodem/network-registration.c
>>> +++ b/drivers/atmodem/network-registration.c
>>> @@ -722,6 +722,8 @@ static void ifx_ctzv_notify(GAtResult *result,
>>>  	gpointer user_data) nd->time.mday =3D mday;
>>>  	nd->time.mon =3D mon;
>>>  	nd->time.year =3D 2000 + year;
>>> +
>>> +	ofono_netreg_time_notify(netreg, &nd->time);
>>>  }
>>> =

>>>  static void ifx_ctzdst_notify(GAtResult *result, gpointer
>>> user_data)
> =

>> Whenever there is a timezone change, CTZV, CTZDST and XNITZINFO URCs
>> will be reported. That is the main reason behind calling the
>> ofono_netreg_time_notify from CTZDST. Are you pretty sure this is not
>> the case?
> =

> I don't know the details of ifx modem internals. If the time
> changes, is it always guaranteed that CTZDST is sent and that
> CTZDST comes after the CTZV? All I know that when testing
> NITZ with ifx modem, the time notification is not emitted without my
> fix. =


ofonod[454]: Net: < \r\n+XNITZINFO:
"GMT+00:00","08/01/01,13:00:00"\r\n\r\n+CTZDST: 0\r\n
ofonod[454]: drivers/atmodem/network-registration.c:ifx_ctzdst_notify()
dst 0
ofonod[454]: examples/nettime.c:example_nettime_info_received() Received
a network time notification on modem: 0x83fc058
ofonod[454]: examples/nettime.c:example_nettime_info_received() Time:
2008-01-01 13:00:00-00:00 (DST=3D0)
ofonod[454]: Net: < \r\n+CTZV: +00,"11/01/27,14:24:43"\r\n
ofonod[454]: drivers/atmodem/network-registration.c:ifx_ctzv_notify() tz
+00 time 11/01/27,14:24:43
ofonod[454]: Net: < \r\n+XNITZINFO:
"GMT+00:00","11/01/27,14:24:43"\r\n\r\n+CTZDST: 0\r\n
ofonod[454]: drivers/atmodem/network-registration.c:ifx_ctzdst_notify()
dst 0
ofonod[454]: examples/nettime.c:example_nettime_info_received() Received
a network time notification on modem: 0x83fc058
ofonod[454]: examples/nettime.c:example_nettime_info_received() Time:
2011-01-27 14:24:43-00:00 (DST=3D0)
......
ofonod[454]: Net: < \r\n+CTZV: +04,"11/01/27,15:24:43"\r\n
ofonod[454]: drivers/atmodem/network-registration.c:ifx_ctzv_notify() tz
+04 time 11/01/27,15:24:43
ofonod[454]: Net: < \r\n+XNITZINFO:
"GMT+00:00","11/01/27,15:24:43"\r\n\r\n+CTZDST: 1\r\n
ofonod[454]: drivers/atmodem/network-registration.c:ifx_ctzdst_notify()
dst 1
ofonod[454]: examples/nettime.c:example_nettime_info_received() Received
a network time notification on modem: 0x83fc058
ofonod[454]: examples/nettime.c:example_nettime_info_received() Time:
2011-01-27 15:24:43-00:00 (DST=3D0)

From the logs, it can be seen that we receive CTZV, XNITZINFO and CTZDST
when the time changes.

This log is taken some time back. Possible that Network Daylight Saving
Time is received as part of the MM information message whereas
it may not be in your case.

Regards,
Jeevaka

--===============6236196144686263224==--

