Content-Type: multipart/mixed; boundary="===============7980608692739753167=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] dbus: fix appending on dict for types other than string
Date: Wed, 05 Jan 2011 16:20:25 -0800
Message-ID: <1294273225.2521.35.camel@aeonflux>
In-Reply-To: <1294248306-14413-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7980608692739753167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> According to dbus documentation, dbus_message_iter_append_basic()
> expects a "const char**" if type is string and a simple pointer for
> other types. Since we a iterating an array, the value passed is already
> a pointer.
> ---
>  src/dbus.c |   20 ++++++++++++++++++--
>  1 files changed, 18 insertions(+), 2 deletions(-)

patch has been applied. Thanks.

Regards

Marcel



--===============7980608692739753167==--

