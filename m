Content-Type: multipart/mixed; boundary="===============1185344575551152433=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SAT support in oFono
Date: Fri, 21 Jan 2011 10:13:22 -0600
Message-ID: <4D39B0A2.8060204@gmail.com>
In-Reply-To: <3A42A4F4F2ABA44EBD5853ED099266471247BFC116@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1185344575551152433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

On 01/21/2011 02:44 AM, Lasse.Kunnasluoto(a)tieto.com wrote:
> Hi
> =

> I am checking what is the level of SAT/STK support in ofono and have a co=
uple of questions. The current implementation contains support for basic ST=
K commands, like menus, inputs, calls, sms and so on. In TODO, there is onl=
y REFRESH command on the list.
> =

> Is there plans or ideas to extend the support in oFono Core with more com=
plex STK features like (3GPP TS 31.111):
> - Call control by USIM
> - MO SMS Control by USIM

Let us set aside the the merits of the use cases for these features for
the moment ;)  Implementing Call control by USIM is fairly
straightforward to do in the core.  However, no modem manufacturer
currently allows us to have full control over this feature.  It is
implemented in the firmware and every vendor does this differently.  So
for now support of this feature is in the realm of the modem driver.

> - BIP (Bearer independent protocol), including commands like OPEN CHANNEL=
, CLOSE CHANNEL, SEND/RECEIVE DATA

Please feel free to add a new TODO item adding these features and send
us patches :)

> - Extend support in PROVIDE LOCAL INFO

What support are you looking for?  Most of the information that is asked
by provide local info is implemented in the modem firmware.  We have
only included support for items which are not covered by the firmware.

> - EVENT DOWNLOAD / SET UP EVENT LIST
> =


Again, which ones are you looking for?  oFono explicitly ignores the
following two events as these make no sense in the smartphone context:

- Idle Screen Available
- User Activity

Regards,
-Denis

--===============1185344575551152433==--

