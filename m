Content-Type: multipart/mixed; boundary="===============6619401635528517674=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC v2 7/7] STE-plugin: GPRS driver.
Date: Tue, 19 Jan 2010 11:55:39 -0800
Message-ID: <1263930939.5591.197.camel@localhost.localdomain>
In-Reply-To: <1263917513-6756-8-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6619401635528517674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Updates after review:
> Removed setting of IP-address, netmask etc. when creating the IP interfac=
e.
> Split caif_if_create_remove() into , caif_if_create() and caif_if_remove(=
).
> Declared interface as array in conn_info struct, and removed memory alloc=
ation.
> Removed switching of syntax runtime (from strict to permissive and back a=
gain).
> Removed return statement from cgev_notify()
> =

> Remaining issues:
> Use glib xml parser.

I am not comfortable with merging this until we have a version that uses
the GLib builtin XML parser.

As mentioned before, lets get the core patches merged and then we work
on voicecall and GPRS in separate patch reviews. That makes it simpler.

Regards

Marcel



--===============6619401635528517674==--

