Content-Type: multipart/mixed; boundary="===============4774630671434912647=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 18:31:39 +0200
Message-ID: <fe2ef791-e8de-c3ca-b430-8a5c6ddec9c6@southpole.se>
In-Reply-To: <CAKSBH7HM4=+bM_aKXTYrnTCAUxzKknQMgwogQx4qBQH-Rn7S4A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4774630671434912647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 12/10/18 18:23, Giacinto Cifelli wrote:
> actually:
>
>>> +
>>> +     if (g_at_chat_send(cbd->ldd->chat, buf, NULL,
>>> +                     at_lte_set_auth_cb, cbd, g_free) > 0)
>>> +             return;
>>> +
>> Here you'll leak cbd again.
> here there is a g_free in the call. Also in case of failure the g_free
> is executed, I think (also because it is the same construct as
> everywhere else).
> Or not?

If g_at_chat_send returns 0, g_free() won't be called so you need to =

free the data yourself.=C2=A0 That should be the construct used elsewhere s=
o =

if you see it done differently your seeing bugs (probably).

/Jonas


--===============4774630671434912647==--

