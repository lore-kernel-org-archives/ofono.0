Content-Type: multipart/mixed; boundary="===============6556332542523995438=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix modem doesn't auto register to network issue
Date: Thu, 12 Sep 2013 08:43:40 -0500
Message-ID: <5231C50C.1070704@gmail.com>
In-Reply-To: <DA62CA5DDF4CA640AA25B1684E5D141101D86039@SHSMSX102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6556332542523995438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 09/11/2013 09:48 PM, Zhang, Caiwen wrote:
> Hi Denis,
>
>>> Some modem may return registration status whitch is out of the range
>>> (0-5). it will cause the modem don't auto register to network when
>>> network atom initializes.
>>
>> oFono core will not validate values outside what is defined in 27.007.
>> If your driver reports such values, then it is an obvious bug in the dri=
ver.
>>
>> Please fix your modem driver.
>>
>
> (status =3D=3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED ||
> 		status =3D=3D NETWORK_REGISTRATION_STATUS_DENIED ||
> 		status =3D=3D NETWORK_REGISTRATION_STATUS_UNKNOWN)
>
> Above checking tries to list the cases that should trigger auto network r=
egistration but for the modems which
> extend network registration status may miss some cases.
>
> With the new checking:
> 		(status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
> 			status !=3D NETWORK_REGISTRATION_STATUS_SEARCHING &&
> 			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING))
> it tries to exclude the cases that not required to trigger auto network r=
egistration. In this way, it can avoid
> above issue.

Since we do not know what the meaning of the extended value actually is, =

we can be wrong in either situation.  The core only knows about values =

defined in 27.007 or values it defines explicitly inside include/*.  If =

we start having the core deal with every single vendor extension then we =

will quickly go insane and the core becomes unreadable.

I have been and will continue to be quite adamant here.  Fix. Your. Driver.

>
> I am not sure whether other modem has the same issue. This way should be =
more make sense.
>
> By the way, it should be better to change the status from "int" to " enum=
 network_registration_status" to avoid modem driver pass
> in value we don't expect.

How does this help you?  If your modem reports issues outside the range, =

you still need to sanitize the values you send to the core.  If your =

modem is compliant, then converting them to an enum just leads to you =

writing more code that does nothing useful.

We've tried this already and abandoned it long ago.

Regards,
-Denis

--===============6556332542523995438==--

