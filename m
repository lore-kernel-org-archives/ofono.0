Content-Type: multipart/mixed; boundary="===============9006087272217497969=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Handling empty row from AT command
Date: Wed, 20 Jun 2018 08:20:13 -0500
Message-ID: <d72eb358-78a5-ef3d-c1fe-8ec83fcba27c@gmail.com>
In-Reply-To: <AM5PR1001MB11716B2FEF6BCFC4D2E4C45596770@AM5PR1001MB1171.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9006087272217497969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mattias,

On 06/20/2018 02:34 AM, Mattias M=C3=A5nsson wrote:
> I'm integrating a new Cinterion module and have a small issue I haven't =

> been able to solve nicely in Ofono. One of their commands responds with =

> a list of stuff, followed by an OK but also after the OK there is an =

> empty line. Which is of course wrong, but it might not be solved for a =

> while.=C2=A0Using the g_at_chat_send function with a callback doesn't see=
m to =

> work then, the callback will not be called it seems=C2=A0and I get stuck =
in =

> the sequence. Can I without modifying the AT parser handle this somehow?
> =


Nope, the parser is what actually drives command recognition.  So =

sending empty commands, etc won't work.

If you're using the gsmv1 parser, then try switching to permissive. =

Permissive is generally able to deal with such situations.

Regards,
-Denis

--===============9006087272217497969==--

