Content-Type: multipart/mixed; boundary="===============7872633993037808706=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Wed, 19 Sep 2018 13:23:58 -0500
Message-ID: <99acf5e5-ee78-216b-4651-e9aff31cb839@gmail.com>
In-Reply-To: <CAKSBH7H+iSZu6OUq56+EAY-kQ3o=fwMDSWTHz49PHBxCq6jHhA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7872633993037808706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> I had a look at this all, and I have a problem. I cannot check the =

> parameters as they are entered one by one.
> Example: if I blank user/pwd when the authentication is changed to NONE, =

> then if changed again to CHAP, the module will reject it.
> Shall I store the parameters, or keep them also in case of error?

So in the case of ConnectionContext the parameters are not sent out to =

the driver until context activation is attempted.  Hence all the =

settings are immediate and the activation fails or it succeeds.

However, in the LongTermEvolution driver setup the settings are =

immediate.  Thus the D-Bus API you propose is thus not really suitable =

and needs to be modified. Since we're kind of stuck with the =

'DefaultAccessPointName' property at this point, the only two ways out =

of this I can think of are:

- Have the driver handle this.  So if PAP/CHAP is selected but username =

or password are invalid, default to no authentication.  The assumption =

will be that eventually valid parameters are given.

Or perhaps we only call out into the driver method once the parameters =

in their entirety are valid, accepting whatever the user puts in as long =

as the individual property input is valid according to core validity checks.

....

> =

> Another way would be to have a SetParameters() function, and set them =

> all together, including the APN, and not allowing writing them =

> separately, apart from the APN which already exists.
> I don't really like it, either.
> =


As you point out, this is the second alternative.  AuthenticationMethod, =

Username & Password would need to be set via a method call and =

optionally exposed as [readonly] properties.  Protocol could still be =

handled as per DefaultAccessPointName or inside the aforementioned =

method call.

> Or introduce an atom function that is called before modem->set_online(tru=
e)?
> =


This might be trickier, but could also work...

Regards,
-Denis

--===============7872633993037808706==--

