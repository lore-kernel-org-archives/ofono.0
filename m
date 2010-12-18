Content-Type: multipart/mixed; boundary="===============6718716191661015248=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] ifx: Adding modem selftest to Infineon modem
Date: Sat, 18 Dec 2010 14:48:52 -0600
Message-ID: <4D0D1E34.8000703@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9015A2476B7@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6718716191661015248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

On 12/18/2010 01:58 PM, Bastian, Waldo wrote:
>>> @@ -80,6 +82,18 @@ static const char *dlc_nodes[NUM_DLC] =3D { "/dev/tt=
yGSM1", "/dev/ttyGSM2",
>>>  =

>>>  static const char *none_prefix[] =3D { NULL };
>>>  static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
>>> +static const char *empty_prefix[] =3D { "", NULL };
>>
>> This is still wrong. See my comment from the original email. I am not
>> sure you really know what { "", NULL } means.
> =

> The response doesn't really have a proper prefix (see example below), thi=
s way the entire response ends up in the callback. Is there a better way? G=
iven that there aren't any URC registered yet, it will not interfere with a=
ny other response. It's obviously not a good idea to use it once the modem =
is powered up.
> =


Then simply passing NULL instead of empty_prefix is sufficient.

Regards,
-Denis

--===============6718716191661015248==--

