Content-Type: multipart/mixed; boundary="===============4307509004128460586=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH] mbmmodem: Fix ip netmask should be 255.255.255.255
Date: Wed, 23 Jun 2010 15:40:49 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F544ACE@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1277276303.2301.174.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4307509004128460586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann wrote:
> Hi Zhenhua,
> =

>> Change static IP netmask to 255.255.255.255.
>> ---
>>  drivers/mbmmodem/gprs-context.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> =

>> diff --git a/drivers/mbmmodem/gprs-context.c
> b/drivers/mbmmodem/gprs-context.c
>> index cca5087..2d0e4e2 100644
>> --- a/drivers/mbmmodem/gprs-context.c
>> +++ b/drivers/mbmmodem/gprs-context.c
>> @@ -48,7 +48,7 @@
>> =

>>  #define MAX_DNS 5
>> =

>> -#define STATIC_IP_NETMASK "255.255.255.248"
>> +#define STATIC_IP_NETMASK "255.255.255.255"
>> =

>>  static const char *none_prefix[] =3D { NULL };
>>  static const char *e2ipcfg_prefix[] =3D { "*E2IPCFG:", NULL };
> =

> did you see a problem with this or why do you propose this change. The
> old f35xx gives this netmask back when using DHCP. What does the f36xx
> and later return when using DHCP?

I tested f3607gw again and found the netmask 255.255.255.248. Originally, I=
 thought it should be consistent with atmodem netmask value. Why the netmas=
k is xx.248 instead of xx.255? If I use wvdial to dial GPRS on f3607gw, the=
 netmask is 255.255.255.255 from ifconfig output.
 =

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============4307509004128460586==--

