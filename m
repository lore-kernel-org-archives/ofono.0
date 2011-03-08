Content-Type: multipart/mixed; boundary="===============0420254920021502353=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH] atmodem: Enable network time for AT modem
Date: Tue, 08 Mar 2011 19:46:14 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802E70733@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1299604359.2497.5.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0420254920021502353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

ofono-bounces(a)ofono.org wrote:
> Hi Antti,
> =

>>  drivers/atmodem/network-registration.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>> =

>> diff --git a/drivers/atmodem/network-registration.c
>> b/drivers/atmodem/network-registration.c
>> index 4913611..2d589f0 100644
>> --- a/drivers/atmodem/network-registration.c
>> +++ b/drivers/atmodem/network-registration.c
>> @@ -722,6 +722,8 @@ static void ifx_ctzv_notify(GAtResult *result,
>>  	gpointer user_data)  	nd->time.mday =3D mday; nd->time.mon =3D
mon;
>>  	nd->time.year =3D 2000 + year;
>> +
>> +	ofono_netreg_time_notify(netreg, &nd->time);
>>  }
>> =

>>  static void ifx_ctzdst_notify(GAtResult *result, gpointer user_data)
> =

> actually this time notification is a bad idea since you will
> notify twice now. With the firmware that I tested this with,
> it is guaranteed to always get CTZV and CTZDST and in that order.
> =


As said in the other mail, CTZDST will be reported only when
the Network Daylight Saving Time information element is received as
part of the MM information message.

If DST information element is received, then the CTZDST will be received
after the CTZV.

I suppose in your case, DST information element is received with the MM
information message.

Regards,
Jeevaka =20

--===============0420254920021502353==--

