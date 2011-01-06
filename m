Content-Type: multipart/mixed; boundary="===============8407637652047196831=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Thu, 06 Jan 2011 09:39:21 -0800
Message-ID: <1294335561.2501.4.camel@aeonflux>
In-Reply-To: <AANLkTimxkKAjcEdS9hGLECWEaW4o+ygPU3RCikFpcK0i@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8407637652047196831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > +static void gprs_cid_take(struct ofono_gprs *gprs, unsigned int id)
> > +{
> > +       idmap_take(gprs->cid_map, id);
> > +}
> > +
> How do we assure that this CID is not already in use?
> I think the M7400 is going to use CID=3D0 and M700 uses CID=3D1.
> Perhaps we should make sure CID=3D0 is a legal value and reserve CID 0
> and 1 at start up.

I thought that we came to the conclusion that CID=3D0 is pretty much a
really bad idea. So I would prefer that your modem is actually not using
CID=3D0 ever.

Regards

Marcel



--===============8407637652047196831==--

