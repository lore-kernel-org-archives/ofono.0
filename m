Content-Type: multipart/mixed; boundary="===============6500143489173846526=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] G1: move chat handling into enable callback
Date: Fri, 02 Oct 2009 04:46:53 +0200
Message-ID: <1254451613.2659.119.camel@localhost.localdomain>
In-Reply-To: <20090929235359.2b3dffd7@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6500143489173846526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

> This updates the g1 code to create the GAtChat object in the enable() cal=
lback,
> and to unref it in the disable() callback.  This is more in line with what
> the other plugins do, and as a bonus fixes a segfault when powering down
> the G1 modem..
> =

> Signed-off-by: Andres Salomon <dilinger@collabora.co.uk>

I see that Denis has applied this patch. In the future, please leave the
Signed-off-by lines out since we are not using them inside oFono. That
is more a kernel commit thing.

Regards

Marcel



--===============6500143489173846526==--

