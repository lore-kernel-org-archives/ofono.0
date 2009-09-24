Content-Type: multipart/mixed; boundary="===============2468918703525277803=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Patch]Unref GIOChannel in g_at_chat_new_from_tty
Date: Thu, 24 Sep 2009 10:02:47 -0700
Message-ID: <1253811767.2931.18.camel@localhost.localdomain>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E089B3D5AEE@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2468918703525277803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Attached is the patch to unref GIOChannel in g_at_chat_new_from_tty. If t=
he =

> GAtChat is created from g_at_chat_new, the reference count of channel is =

> increased by g_io_add_watch_full(channel), so we need to unref it.
> =

> If GAtChat is failed to create, we also need to unref channel to free it.

patch has been applied. Thanks.

Regards

Marcel



--===============2468918703525277803==--

