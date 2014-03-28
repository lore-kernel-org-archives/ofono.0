Content-Type: multipart/mixed; boundary="===============0524726105406471575=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Particular APN and Ofono+Connman+BBB+Buildroot
Date: Fri, 28 Mar 2014 09:43:57 -0500
Message-ID: <53358AAD.5030302@gmail.com>
In-Reply-To: <CAM5ihG_a-o9YpTw7A034oD9kJ9Y8D2A5Cfiii_JrjsHN==C+jQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0524726105406471575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jer=C3=B4nimo,

> Ok, if I write my own how can I include it to my application? Do I need
> to include this source file in ofono compilation or is there another way?
>

The easiest is to include it into oFono source.  We do support external
plugins but I can't point you to an example off the top of my head.
There were a couple of external plugins in the past.  See src/plugin.c
and Makefile* to see how to do this.

> Another question, make both work at the same time? I mean, make ofono
> look first at 'my own provider', if doesn't have a specific APN, look at
> the Mobile Broadband Provider.

This can be done by setting the plugin priority appropriately. Plugins
with higher priorities are queried first.

> That's nice, but I need Python to achieve that. I would like to keep the
> system (an embedded one) as simple as possible, and for now I don't have
> Python, I don't think it's a good idea to include it just for that.
> =

> Can I do that with C? =


Sure.  Python just gives you an example of what D-Bus properties to set.

> =

> If so, what is the difference between first method and this one?

No difference in the end.  For an embedded system which has no user
input, the provisioning approach will likely be easier.

Regards,
-Denis

--===============0524726105406471575==--

