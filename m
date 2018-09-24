Content-Type: multipart/mixed; boundary="===============1522094036917602731=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: commit d37c22be20c83cf370638a9bad243bc5219c5509
Date: Mon, 24 Sep 2018 08:24:04 +0200
Message-ID: <809730A9-6AF4-4CF2-A17E-5BB6ACC58E09@holtmann.org>
In-Reply-To: <CAKSBH7HDxmrBEGDAnzDGgdQEs9LwjcBGkShn_xw47rrAU9=rbA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1522094036917602731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> > was it necessary to remove entirely the NEED_THREADS flag?
> > =

> > I was going to use it in the Gemalto driver, to speed up the device rec=
ognition, because for some modules it is hit and miss.
> > But only as an optional feature, because in some systems it might be mi=
ssing.
> > =

> > Also, for some high-speed modems which take long to boot, there is a po=
tential critical race in the recognition that the use threads can solve eas=
ily. The alternative is to increase the internal timers a lot.
> > =

> > I likely need to add a new flag for it.
> =

> using threads is not the solution. This can be all done properly with sin=
gle thread event loop driven methods.
> =

> for sure, and in fact as of now the support is optional.
> But I already need to ask for an extension of the Powered timout from 20 =
to 60 seconds because several LTE chipsets take at least 30-40 seconds to b=
oot once they have already enumerated on USB. It would be good to shorten t=
his time.
> =

> Besides, several modules use the option linux driver, which blocks in cas=
e the port doesn't answer.
> This single call:
> 	g_at_chat_unref(port);
> blocks either 30s or 1 minute, depending on the system. I might step into=
 it twice during my hardware initialization for several 3G models.
> It helps to run this line on a separate thread unblocking the rest.

no it does not. Nothing in GAtChat is thread safe. So running this in a sep=
arate thread just means you are having tons of race conditions on your hand.

Regards

Marcel


--===============1522094036917602731==--

