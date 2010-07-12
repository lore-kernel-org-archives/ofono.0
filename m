Content-Type: multipart/mixed; boundary="===============5218026994631373894=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: [PATCH 2/6] bluetooth: Add register service for bluetooth
Date: Mon, 12 Jul 2010 10:03:46 -0300
Message-ID: <20100712130346.GA13910@vigoh>
In-Reply-To: <33AB447FBD802F4E932063B962385B351F77024A@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5218026994631373894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> >> =

> >> -int bluetooth_register_uuid(const char *uuid, struct
> >>  bluetooth_profile *profile) +static int bluetooth_init() {
> > =

> > So I prefer a real refcount structure here, and call this
> > bluetooth_ref(). What do you think?
> =

> Good idea. Bluetooth_ref/unref makes more sense if we have both HFP and D=
UN existings on the system.
> =

> Actually I have an unrelated question here. Why we don't have something l=
ike DUN_GW_UUID string so that we can easily reuse your current code? For n=
ow, we need to register service and use a different hash table to record th=
at.

I'm fine with that, but you have to use the DUN Data Terminal UUID
instead.

-- =

Gustavo F. Padovan
http://padovan.org

--===============5218026994631373894==--

