Content-Type: multipart/mixed; boundary="===============8934909999285661828=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [offline-atoms PATCH 1/2] Make gprs atom offline-safe.
Date: Wed, 19 Jan 2011 10:57:12 -0600
Message-ID: <4D3717E8.3050103@gmail.com>
In-Reply-To: <AANLkTing29eqccHn1Y5_V1g=BELX0HJKMa3_MYD9SaW4@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8934909999285661828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 01/19/2011 07:33 AM, Pekka Pessi wrote:
> Hi Denis,
> =

> 2011/1/19 Denis Kenzior <denkenz@gmail.com>:
>>> +     if (gprs->netreg =3D=3D NULL) {
>>> +             gprs_netreg_removed(gprs);
>>> +             return;
>>> +     }
>>> +
>>
>> I'm having trouble visualizing why this chunk is necessary.  We reset
>> netreg to NULL only when shutting down the atom or when netreg atom goes
>> away.  So this condition should never be triggered.
> =

> It is for the case where the gprs atom is inserted in post_sim but
> netreg in post_online.
> =


I still don't see it, applying your patch and removing this chunk works
just fine.  I can set Powered / Roaming Allowed with no issues...

Regards,
-Denis

--===============8934909999285661828==--

