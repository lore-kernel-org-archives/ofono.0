Content-Type: multipart/mixed; boundary="===============4129871239937532953=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 04/30] qmi: request_alloc has no meaningful failure
 path
Date: Wed, 28 Mar 2018 16:12:08 -0500
Message-ID: <bddde607-dde0-9166-4184-aa35ad5c79b6@gmail.com>
In-Reply-To: <1e41b3cc-ff54-be3e-1ccd-714501e52c81@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4129871239937532953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>> Why now g_new0?=C2=A0 What's your plan here, are you wanting to get rid =
of =

>> glib entirely?=C2=A0 If so, then we might as well start using ell for QM=
I, =

>> which is a long term goal anyway.
> =

> Well, you did say that getting rid of glib was a long term goal. =

> Introducing ell introduces a new library; calloc() is a standard libc =

> function.=C2=A0 I=C2=A0 did look at ell but deemed that introducing ell a=
t the =

> same time as trying to untangle the QMI mess was beyond the budget that =

> I have allocated for this work.

Yes, except you still need main event loop integration, timers, and =

various data structures.  GLib doesn't like you mixing g_free/free and =

malloc/g_malloc/g_new.  And we don't use malloc / calloc anywhere else. =

So you either stick to GLib or we take the opportunity and convert =

everything over to ell.  So pick your poison and stick with it.

> =

> Based on what you have said earlier, I am working under the assumptions =

> that:
> i)=C2=A0 glib is of no importance and it would be desirable to remove the =

> dependency on it
> ii)=C2=A0 ofono is Linux-only
> =


This is true, but really it means to switch to ell.  It doesn't mean we =

should go off into the woods and start making qmi completely unlike =

anything else in the project code base.

Regards,
-Denis

--===============4129871239937532953==--

