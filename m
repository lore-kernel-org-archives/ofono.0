Content-Type: multipart/mixed; boundary="===============3254731203216982335=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Thu, 15 Apr 2010 16:54:07 -0500
Message-ID: <201004151654.07986.denkenz@gmail.com>
In-Reply-To: <y2m80fd4e751004120708t38e61cd5r29ee0bc48c8fe593@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3254731203216982335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> Attached.

In the future, can you please use git-send-email so that I can comment on t=
he =

patch much easier.

> =

> >  So far I like the idea of disable having a
> > hint on whether a shutdown is in progress more than an explicit shutdown
> > method.
> =

> That is also possible, but then we need also more power states
> (besides off and on).
> =


After taking a look, I'm even more convinced that a hint to disable is less =

invasive.  The proposal is simply way too complicated.  With a hint the dri=
ver =

can take the necessary steps to disable the modem (what is done by shutdown =

now) and return once it finishes.  The ofono exit logic does not need to ch=
ange =

at all with this approach...

Regards,
-Denis

--===============3254731203216982335==--

