Content-Type: multipart/mixed; boundary="===============0865798182530947799=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 22:58:12 +0300
Message-ID: <200906112258.12298.remi@remlab.net>
In-Reply-To: <1244747882.27363.65.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0865798182530947799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le jeudi 11 juin 2009 22:18:02 Marcel Holtmann, vous avez =C3=A9crit :
> Hi Aki,
>
> > >> For geolocation help, sure, but there are other places where MNC/MCC
> > >> are used as keys to databases containing operator-specific
> > >> information, like default Internet APN names and such.
> > >
> > > shouldn't we just integrate that database into oFono directly or as
> > > something like ofono-info.git that will be installed along with (for
> > > easier updates).
> >
> > This particular database of default APN names, maybe, although I think
> > it's really oFono users like Connman that should integrate with that
> > information.
> >
> > However, this wouldn't be the only database ever, so we would still need
> > a way to reliably identify a specific operator.
>
> if we are unclear about the format and the users at this moment, I
> prefer we remove that interface and just keep it around as a TODO item
> to add it later.

I don't see any lack of clarity. It is a series of two or three digits.

Anyway, if the database has a hole, we probably will have to return the =

MNC/MCC anyway (ever tried scanning for network with an old phone in a fore=
ign =

country?). Then there is also the uniqueness problem. MNC/MCC pair solves =

that.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/


--===============0865798182530947799==--

