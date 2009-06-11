Content-Type: multipart/mixed; boundary="===============7794660831250518410=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 22:33:05 +0200
Message-ID: <1244752385.27363.67.camel@violet>
In-Reply-To: <200906112258.12298.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7794660831250518410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > >> For geolocation help, sure, but there are other places where MNC/M=
CC
> > > >> are used as keys to databases containing operator-specific
> > > >> information, like default Internet APN names and such.
> > > >
> > > > shouldn't we just integrate that database into oFono directly or as
> > > > something like ofono-info.git that will be installed along with (for
> > > > easier updates).
> > >
> > > This particular database of default APN names, maybe, although I think
> > > it's really oFono users like Connman that should integrate with that
> > > information.
> > >
> > > However, this wouldn't be the only database ever, so we would still n=
eed
> > > a way to reliably identify a specific operator.
> >
> > if we are unclear about the format and the users at this moment, I
> > prefer we remove that interface and just keep it around as a TODO item
> > to add it later.
> =

> I don't see any lack of clarity. It is a series of two or three digits.
> =

> Anyway, if the database has a hole, we probably will have to return the =

> MNC/MCC anyway (ever tried scanning for network with an old phone in a fo=
reign =

> country?). Then there is also the uniqueness problem. MNC/MCC pair solves =

> that.

if the database has a whole or we don't have the network provider string
then we can just show the MNC/MCC in that case. That is pretty simple.
No need to put extra burden into the userspace application and have it
looking for two strings.

I don't understand your uniqueness issue. We will have unique object
path for every network. What else does userspace needs?

Regards

Marcel



--===============7794660831250518410==--

