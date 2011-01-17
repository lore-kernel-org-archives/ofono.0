Content-Type: multipart/mixed; boundary="===============5021228810725728503=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Mon, 17 Jan 2011 08:20:44 +0200
Message-ID: <1295245244.2153.13.camel@jsaunama-desktop>
In-Reply-To: <1295055010.3873.155.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5021228810725728503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

On Sat, 2011-01-15 at 02:30 +0100, Marcel Holtmann wrote:
> > > I would advise the UI against using the name from the context
> > > information and better using the one from the network registration
> > > instead.
> > =

> > Well that would make sense... Therefore the operators don't do it ;-)
> > =

> > For instance my provider shows as "Elisa" in the network registration b=
ut the =

> > access points are expected to be shown as "Elisa Internet" and "Elisa M=
MS WAP" =

> > if I recall correctly.
> > =

> > It only makes sense to have this data in the provisioning plugin. It wo=
uld be =

> > silly to have to provision just the names in a different component.
> =

> just to make this clear, oFono takes care of potential operator renames
> and displays them accordingly, but the provision names would stay the
> same.
> =

> So if Elisa renames themselves into "Gwendula", the context names would
> still say "Elisa Internet" etc. Has anybody thought about this part?

Well, there is always OMA Client Provisioning for that purpose.

However, I would leave this question to UX designers and someone that
actually knows operator requirements regarding which name (network
provided or provisioning/gprs-context name) to show for Internet access
selection.
Also, by the way, when roaming, network name is different from normal
home name, and this may or may not be desirable for internet access
name...

In any case, regarding the original issue if reading SPN is really
needed for provisioning, the answer is still yes. There are cases where
different SPN means different gprs context settings (other than 'Name'
too).

--Jukka



--===============5021228810725728503==--

