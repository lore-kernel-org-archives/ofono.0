Content-Type: multipart/mixed; boundary="===============0882093560759176482=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v5 00/16] Add DUN support
Date: Thu, 05 Jan 2012 14:39:13 +0100
Message-ID: <4F05A801.2030306@monom.org>
In-Reply-To: <4670174.3vOMRVMVBI@hector>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0882093560759176482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 05.01.2012 13:07, R=C3=A9mi Denis-Courmont wrote:
> Le Mercredi 4 Janvier 2012 18:17:34 ext Daniel Wagner a =C3=A9crit :
>> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
>> I think this series is ready to be considered to be merged *hint* :)
> =

> I may be missing something obvious, but why is this a new daemon instead =
of a =

> driver or plugin inside oFono?

There are a few reasons why a modem plugin is not really good. Here an
summary from my original posting on the ConnMan mailing list:


This is the 3rd attempt to get DUN done (pun!). The first and second
attempt was to expose DUN devices through the oFono API. While this
sounds like a reasonable way to go it has some - let's put it
this way - ugliness involved. =


 - No SIM interface: This is not so bad but still we have to hack around
   this problem. Since we need some uniqueness to distinguish between
   services, the Serial property of the Modem interface has to be
   abused for this.
 - No NetworkRegistration interface: DUN only specifies ATD*99# AT command.
   All other AT commands might be supported (such as AT+COPS=3D?) but are n=
ot
   necessarily there. That means we might not get a name for a network. Whe=
reas
   you can rely to get this name for a regular modem you can't on DUN ones.
   And guess what you cannot distinguish between real hardware modems and
   virtual ones unless...
 - Abuse Modem.Type: ... add 'dun' type and adapt the oFono plugin. That
   _is_ though a very bad idea. We just introduce a mighty switch for =

   different oFono API behavior. Denis used strong words against this
   approach.
 - oFono internal design: oFono is not designed to handle this kind
   of modems. The dunmodem implementation is rather obscure. The result
   of this is that, as soon as a DUN device pops up, an Serial channel is
   opened (rfcomm) and kept alive. Unfortunately, there are phones outside
   in the wild which like to close the serial link after PPP stops.
   With oFono's separation of concerns this is not easy to get working.
 - Technology mess: In order to get DUN modems working you have to enable C=
ellular
   and Bluetooth technology. This is really really bad because we expose
   the implementation details to the user. Sure, DUN is kind of dying etc.
   but then, I don't think our standards are so low.

(http://www.mail-archive.com/connman(a)connman.net/msg06971.html)

cheers,
daniel

--===============0882093560759176482==--

