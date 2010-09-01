Content-Type: multipart/mixed; boundary="===============1838200969117767151=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [g_isi_send RFC 0/3] g_isi_send()
Date: Wed, 01 Sep 2010 14:09:06 +0300
Message-ID: <AANLkTi=+R3ow+yU9FWxYP-kYpeCUbXLFnTE8WobMygL7@mail.gmail.com>
In-Reply-To: <1283186559-4548-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1838200969117767151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

2010/8/30  <Pekka.Pessi@nokia.com>:
> I've added the function g_isi_send() to the gisi client API. =C2=A0It has=
 been
> modeled after g_at_chat_send(), in other words, it includes a GDestroyNot=
ify
> function.

Looks good to me. This does simplify the client code quite a bit. In
fact, I don't see why we would want to keep g_isi_request_make() with
this in?

Cheers,
Aki

--===============1838200969117767151==--

