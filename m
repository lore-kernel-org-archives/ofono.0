Content-Type: multipart/mixed; boundary="===============1296295213049982966=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 2/4] netreg: Add CPHS CSP PLMN mode implementation
Date: Wed, 26 Jan 2011 12:32:07 +0200
Message-ID: <AANLkTikGYBZBqo5czuDORzRxOraAJo6c811RrFMs+sAA@mail.gmail.com>
In-Reply-To: <1296035236.1520.93.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1296295213049982966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/26 Marcel Holtmann <marcel@holtmann.org>:
>> diff --git a/src/network.c b/src/network.c
>> index b5450ee..64734d0 100644
>> --- a/src/network.c
>> +++ b/src/network.c
>> @@ -64,6 +64,7 @@ struct ofono_netreg {
>> =C2=A0 =C2=A0 =C2=A0 int cellid;
>> =C2=A0 =C2=A0 =C2=A0 int technology;
>> =C2=A0 =C2=A0 =C2=A0 int mode;
>> + =C2=A0 =C2=A0 gboolean forced_auto;
>
> do we wanna keep it named forced_auto and not better keep this in sync
> with auto_only as we use in the D-Bus API. Or if manual_disabled.

I can rename this auto_only.

>> -static const char *registration_mode_to_string(int mode)
>> +static const char *registration_mode_to_string(int mode, gboolean force=
d_auto)
>> =C2=A0{
>> + =C2=A0 =C2=A0 if (forced_auto)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "auto-only";
>> +
>
> I see the benefit of keeping this in this function, but I would not have
> done it like this actually. I would have kept it next to the function
> needing that string and let it do the auto-only check by itself.

That is how I originally had it, but this ends up being a bit less
code. Also, I'd like to localize all of these constant strings into a
single function and not sprinkle them across the code.

> Another possibility might be to convert this into
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0get_registration_mode_string(struct ofono_netr=
eg *netreg)
>
> Since I am not mistaken, then the netreg->mode is always set before you
> are calling this, right?

No, you call it with the new value. The function will then compare the
old and the new, and based on this decide on sending a
PropertyChanged.

Cheers,
Aki

--===============1296295213049982966==--

