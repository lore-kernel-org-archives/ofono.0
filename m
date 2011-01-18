Content-Type: multipart/mixed; boundary="===============8477366376533297250=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 2/5] netreg: Add CPHS CSP PLMN mode implementation
Date: Tue, 18 Jan 2011 20:54:17 +0200
Message-ID: <AANLkTimMwOtqYQgMLwv0qK2RVXPVdDgnmzXsumn4zOSr@mail.gmail.com>
In-Reply-To: <4D35E14D.9060404@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8477366376533297250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/1/18 Denis Kenzior <denkenz@gmail.com>:
>> We read the value always, yes, but storing the last known value rids
>> us of a superfluous PropertyChanged signal in the case when last value
>> of forced_auto was true, and after reading is still true. This is
>> because forced_auto is by default set to false.
>
> Do you mean across atom instantiations here? =C2=A0If so there are plenty=
 of
> other attributes that get emitted in a similar fashion, so my vote is to
> just emit the signal. =C2=A0Or are you worried about something else?

Nope, that was basically it. I'll remove the code.

Cheers,
Aki

--===============8477366376533297250==--

