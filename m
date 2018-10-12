Content-Type: multipart/mixed; boundary="===============1324389278212209004=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 18:23:46 +0200
Message-ID: <CAKSBH7HM4=+bM_aKXTYrnTCAUxzKknQMgwogQx4qBQH-Rn7S4A@mail.gmail.com>
In-Reply-To: <9e274614-97e2-439c-5b58-4c7946f7fc9f@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1324389278212209004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

actually:

> > +
> > +     if (g_at_chat_send(cbd->ldd->chat, buf, NULL,
> > +                     at_lte_set_auth_cb, cbd, g_free) > 0)
> > +             return;
> > +
> Here you'll leak cbd again.

here there is a g_free in the call. Also in case of failure the g_free
is executed, I think (also because it is the same construct as
everywhere else).
Or not?

 >

--===============1324389278212209004==--

