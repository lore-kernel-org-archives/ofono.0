Content-Type: multipart/mixed; boundary="===============2690778749493939808=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] doc: Add documentation for 'forced-mode'
Date: Tue, 18 Jan 2011 15:03:02 -0600
Message-ID: <4D360006.1040506@gmail.com>
In-Reply-To: <1295382667.3873.227.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2690778749493939808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> The reason I ended up extending the Mode property was that once
>> forced_auto is true, no other Mode than auto is anyway possible. So in
>> a sense it is another type of Mode, which isn't to say a separate
>> property wouldn't work equally well.
>>
>> I'm really open to either option. The way the code is written makes it
>> very easy to just expose this as a separate property.
> =

> the extra "forced-auto" mode feels kinda forced into this property. So
> that is my main concern here.
> =

> However on the other hand the Mode property is actually read-only. If it
> would be a user changeable property then it would be pretty clear that
> we do not wanna intermix this here.
> =

> With this in mind, it might be just fine here from a UI interaction flow
> point of view.
> =

> Denis, what is your take on this?
> =


I'm fine with forced-auto, but we might want to add a new error type to
ofono.h (maybe something like ManualRegistrationNotAllowed) and return
that error when trying to use Scan or NetworkOperator.Register.

Regards,
-Denis

--===============2690778749493939808==--

