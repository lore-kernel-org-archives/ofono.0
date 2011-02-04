Content-Type: multipart/mixed; boundary="===============2613286240469844944=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH v2 3/3] isimodem: header updates for ISI2.5
Date: Fri, 04 Feb 2011 11:05:34 +0200
Message-ID: <AANLkTi=_pF5mSkMsAYhrrrYWmNqz-g9eaXqiewH_AOk3@mail.gmail.com>
In-Reply-To: <4D4A7621.6030508@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2613286240469844944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

2011/2/3 Andreas WESTIN <andreas.westin@stericsson.com>:
>> I don't see what that has to do with the device supporting the "PC
>> suite" USB profile, which allows modem access using cdc_phonet.
>
> Currently our platform does not support this.

Well, I know of platforms that do, and have different versions of ISI modem=
s.

>> That is exactly what I meant. This version allows building quirks inside
>> the drivers. An example in pseudo-code:
>>
>> if GIsiVersion.major =3D=3D 15 and GIsiVersion.minor>=3D 3:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0send( { FOO, value, filler, filler}, callback=
1 )
>> else:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0send( { FOO, value }, callback2 )
>>
>
> Yes, we use a similar solution in gisi, but R=C3=A9mi pointed out that it=
 would
> be a maintenance problem once there are more versions to support and I te=
nd
> to agree. A solution could be to use a lookup function, but this function
> would need to return something to compare with, an enum perhaps.
> Also are you certain that e.g major =3D=3D 15 and minor =3D=3D 25 is stil=
l the same
> ISI version, if not then the lookup function could become messy.

The PNS_SUBSCRIBED_RESOURCES_EXTEND_IND is a bit of a special case, as
it requires quirking inside GIsiModem. But see my other response in
that thread.

Cheers,
Aki

--===============2613286240469844944==--

