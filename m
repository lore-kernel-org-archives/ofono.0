Content-Type: multipart/mixed; boundary="===============8625226300920904331=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: context activation quickly after context deactivation fails
Date: Fri, 07 Sep 2012 11:27:02 +0200
Message-ID: <CABvLYuD5h8WQ_Fm66uFmg2LrRpJNMXZGT2hvo-pK-36aBoDbeg@mail.gmail.com>
In-Reply-To: <5048BD8B.6070103@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8625226300920904331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

> Can you change:
> +       g_at_chat_register(chat, "NO CARRIER", no_carrier_notify,
> +                               FALSE, gc, NULL);
>
> to read:
>
> +       g_at_chat_register(gcd->chat, "NO CARRIER", no_carrier_notify,
> +                               FALSE, gc, NULL);
>

it's working now!

Thanks,
Cedric

--===============8625226300920904331==--

