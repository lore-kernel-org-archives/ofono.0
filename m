Content-Type: multipart/mixed; boundary="===============8755697462782332164=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 0/6] PPP Patches v3
Date: Mon, 22 Mar 2010 23:14:36 -0700
Message-ID: <20100322231436.5ccfe248@kcaccard-MOBL3>
In-Reply-To: <1269319898.11714.25.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8755697462782332164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Mar 2010 21:51:38 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> So Denis and I looked through my changes and he figured out what might
> have broken it. So your attempt at doing code flow optimization with
> g_list_length() throw me on the wrong error path. Please don't do this
> since all the GLib functions will do proper empty list checking.

I reviewed your patch and it seems that you didn't break it this time :).
If you ever have questions about the code, feel free to ask me.

--===============8755697462782332164==--

