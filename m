Content-Type: multipart/mixed; boundary="===============2676834671998414703=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 12/30] qmi: replace GQueues for requests
Date: Wed, 28 Mar 2018 16:24:48 -0500
Message-ID: <09b83411-6aaf-348e-3e19-d2f90150648a@gmail.com>
In-Reply-To: <2f50686d-9be8-726c-987c-abe9c1ce1e44@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2676834671998414703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,
> Anyway, please bear with these lists for this cleanup.=C2=A0 When the sha=
red =

> service cleanup is done, we can return to GQueues if necessary and then =

> we'll have a clearer picture of what the difference is.=C2=A0 As things s=
tand =

> though, things are complicated enough that the GQueues are just in the wa=
y.

I'm not introducing Linux lists just to remove them later.  That just =

won't happen :)

> =

> Trying to find a series of small patches through this cleanup hasn't =

> been easy.=C2=A0 The first attempts I did ended up ballooning because whe=
n =

> you start trying to make the change in patch 29 you pretty much =

> automatically end up with most of the other changes in the preceding 28 =

> patches before this system is operational again... so the alternative to =

> some of these (possibly) oddball patches was one _big_ patch that wasn't =

> reviewable.
> =


I feel your pain :)  I think before you go crazy we should nail down =

your proposed API semantics and how you want things to look like.  I =

already outlined my vision in a previous email and it sounds like you're =

trying for something completely different.  So the obvious question is =

why are we reinventing the wheel again?

Regards,
-Denis

--===============2676834671998414703==--

