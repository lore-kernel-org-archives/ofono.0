Content-Type: multipart/mixed; boundary="===============8144894463745511884=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: A way of polling SIM status
Date: Wed, 20 Oct 2010 23:36:22 +0200
Message-ID: <AANLkTi=hh06TUUFknSEtLTsv-YDQSHiFMQaJ4CT5=YXk@mail.gmail.com>
In-Reply-To: <AANLkTinUHKokaYjfc=jg0tmf+PSwSk7bbOr0FsgzpZom@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8144894463745511884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 20 October 2010 15:21, Pekka Pessi <ppessi@gmail.com> wrote:
> 2010/10/19 Denis Kenzior <denkenz@gmail.com>:
>> Unfortunately some modems report CPIN: READY even though they're not
>> ready. =C2=A0The only reliable way to poll for this is to poll the IMSI,=
 then
>> the phonebook and the sms store and report ready only once all of them
>> can be manipulated.
>
> I seems to me that Caiwen is proposing SIM presence polling. Each and
> every modem does it now separately. Unfortunately this seems to be
> even trickier than PIN lock polling, at least MBM returns different
> error codes depending on how far its own initialization has got.

My MBM seems to only detect the SIM if it is inserted during the modem
enumeration (on USB or PCI).  If you there's no SIM during modem
initialisation, or you extract the SIM, then inserting a new SIM is
never detected, the modem will always return "SIM not inserted" until
reset.

Caiwen, have you looked at drivers/atmodem/sim-poll.c?

Best regards

--===============8144894463745511884==--

