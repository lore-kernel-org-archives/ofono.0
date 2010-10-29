Content-Type: multipart/mixed; boundary="===============2270495147160779939=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 3/6] radio settings: add FastDormancy property
Date: Fri, 29 Oct 2010 10:52:25 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7DCA1F70@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <4CC9947F.8050205@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2270495147160779939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > The fundamental problem here is that there is only a single =

> CACHED flag for multiple properties, which may be modified =

> individually. So, either you get extra signals or you get too =

> few. I checked the CACHED flag here because otherwise the =

> following might happen:
> =

> Yes, I know.  But this problem is present in every single atom.  oFono
> does not guarantee that every attribute is signaled when the atom is
> initialized.

So I gathered. To me this looks like a wider issue, though. InProgress erro=
rs are returned in many other contexts as well, and they are not that well =
documented in the API documentation. All this makes it a bit painful to wri=
te a robust oFono client. Probably this could be at least partially rectifi=
ed by improving the documentation.

> > 1. client tries to GetProperties() and gets the "Operation =

> already in progress" error.
> > 2. client waits for PropertyChanged signal to get the =

> FastDormancy value
> > 3. signal never comes because the default value happens to =

> match the one returned by the driver and the signal is suppressed
> >
> =

> In general I think that for interfaces where this can happen, the
> likelihood is very low that it actually will in the real world.

Perhaps so. The network and SIM interfaces, which are most likely to be bom=
bared by multiple UI components, seem to be doing the right thing at least.

> Do note that I have had the same argument with myself off and =

> on for the
> past two years.  So far this was never raised as an issue.  =

> If this ever
> becomes a problem, we can fix it properly using an appropriate idiom.

If this becomes a problem, it won't necessarily be visible to upstream. Mor=
e likely this will be noticed in product maturization phase, and the fixes =
made to a product specific stable branches might never trickle back to upst=
ream.

> > I do agree that sending extra signals is bad but I think =

> that not sending a signal is even worse. If the client cannot =

> rely on getting a PropertyChanged signal after a busy error, =

> all it can do is resort to polling. I.e., every client has to =

> implement a polling pattern for GetProperties:
> > =

> > while (GetProperties() =3D=3D BUSY)
> > 	sleep(FOR_A_WHILE);
> > =

> > Having a separate CACHED flag for each value would solve =

> this optimally. Failing that, I don't think a few extra =

> signals is so bad. Forcing clients to poll is just ugly.
> > =

> =

> Honestly, if you expect multiple applications to battle over the
> FastDormancy property, then it should be modeled differently.  Perhaps
> with application registration and lifetime tracking over =

> D-Bus, similar
> to how agents work.

Hardly that, FastDormancy is unlikely to be a problem. I was merely curious=
 whether there is a general design rule underneath, or if these things are =
decided on a case by case basis. Based on your comments and looking at the =
code, I guess it's more case by case. I just feel uneasy about an API that =
returns transient errors by design, on the (even if informed) assumption th=
at it will probably be ok. I also dislike the fact that a generic InProgres=
s error pretty much forces a client to just retry each operation until it s=
ucceeds. If there are problems like this, they are most likely discovered o=
nly in the product maturization phase and then it's generally too late to f=
ix the upstream. Too late for that particular product, that is.

Br,

	MikaL

--===============2270495147160779939==--

