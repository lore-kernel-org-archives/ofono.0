Content-Type: multipart/mixed; boundary="===============6064413814360819070=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC v0] ofono: Only register network when APN is set
Date: Tue, 28 Feb 2012 08:33:27 -0800
Message-ID: <1330446807.3392.83.camel@aeonflux>
In-Reply-To: <CAHiDW_HN1X7zX-TpHgpwF=FL_zYxSPVYgtWJyiONERiAbX65WQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6064413814360819070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys,

> > We should now show a network without an APN.
> > ---
> > I have not tested this one. But something like this should do
> > the trick. Maybe someone with deeper knowledge on the APN
> > behavior could explain under which circumstances the APN is set, e.g.
> > see the netreg vs apn setting in this patch. Not sure if this is correc=
t.
> >
> > cheers,
> > daniel
> =

> Thanks Daniel. This sort of works after some fixes but it looks like
> there are still issues if modem or context properties change. I'll
> have a go a fixing it later today. I'm including my initial comments
> below for reference (just in case I don't manage to fix them).

can you please move this to the ConnMan mailing list.

Regards

Marcel



--===============6064413814360819070==--

