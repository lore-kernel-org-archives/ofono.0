Content-Type: multipart/mixed; boundary="===============2575016833779807021=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Use "internet" apn for auto-created context
Date: Sun, 19 Jan 2014 21:12:57 -0600
Message-ID: <52DC9439.5010109@gmail.com>
In-Reply-To: <52DBA831.20000@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2575016833779807021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

 > How can you tell an empty context created by a provisioning plugin from
> an empty context created by gprs.c after all provisioning plugins have
> failed? Or from the access point edited by the user in such a way that
> it looks exactly like the empty context created in gprs.c? You can't.
> They are all identical. Empty context is not a reliable indication of a
> provisioning failure.
>

If your provisioning plugin returns bogus data, then the provisioning =

plugin is broken and needs to be fixed.  What exactly are you arguing?

If people start deploying plugins that return bogus / invalid =

information, then the core can validate the provisioning information =

just like it validates the D-Bus API.

> A better, unambiguous indication would be to not create any contexts at
> all. Actually, I was assuming that it was the case and was quite
> surprised to find out that it was ofono creating the default context.

No, it is not.  All contexts can be removed by the application, this is =

not an 'impossible' condition.  A context with an empty APN cannot be =

created programmatically.

>
> It's surely not breaking anything for Jolla. It would only improve
> chances of GPRS access to work out of the box. But of course in theory
> it may break something on some other platform. Any change, even an
> obvious bug fix can break existing behavior.
>
> Finally, about 15% of all GPRS Internet access points in the world are
> called "internet" and have no user name or password. It's by far the
> most common use case. So it's not a wild guess at all. It's real life
> experience.

And you can easily implement this behavior as a plugin if you so desire.

Regards,
-Denis

--===============2575016833779807021==--

