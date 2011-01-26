Content-Type: multipart/mixed; boundary="===============2338235262002304645=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [gprs-provision RFCPATCHv6 0/4] Plugin API for provisioning of
 GPRS context settings
Date: Wed, 26 Jan 2011 10:57:01 +0100
Message-ID: <1296035821.1520.100.camel@aeonflux>
In-Reply-To: <1295959664.6035.14.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2338235262002304645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> > I think that our only leftover is how we handle the SPN detail.
> > =

> > Denis, what is your preference here? My take would be that we store it
> > inside network registration and provide it to external modules. I don't
> > see a point in reading it twice.
> =

> New SPN specific API in SIM atom? Asynchronous with callback, but SIM
> would need to read it only once.
> Unless there is some simple way to start reading it right after SIM is
> ready/unlocked and netreg and gprs are registered only after SPN read
> returns?

lets get this merged without support for SPN for now. We can easily add
this later. So please fix Denis' comments and re-submit this without the
SPN change.

Andrew is currently looking into fixing the SIM reading race. Once that
is done we can tackle the SPN part. Feel free to add a TODO item for
adding access to SPN information.

Right now I think we need to do that in the SIM atom, store it, and then
provide it for netreg and other plugins that might want it. However we
might need to discuss this a bit further.

Regards

Marcel



--===============2338235262002304645==--

