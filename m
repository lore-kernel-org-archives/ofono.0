Content-Type: multipart/mixed; boundary="===============5406079719548815071=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: A way of polling SIM status
Date: Thu, 21 Oct 2010 04:39:32 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE805CEE8C6@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <AANLkTi=hh06TUUFknSEtLTsv-YDQSHiFMQaJ4CT5=YXk@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5406079719548815071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi andrzej,

> =

> On 20 October 2010 15:21, Pekka Pessi <ppessi@gmail.com> wrote:
> > 2010/10/19 Denis Kenzior <denkenz@gmail.com>:
> >> Unfortunately some modems report CPIN: READY even though they're not
> >> ready. =C2=A0The only reliable way to poll for this is to poll the IMS=
I,
> then
> >> the phonebook and the sms store and report ready only once all of
> them
> >> can be manipulated.
> >
> > I seems to me that Caiwen is proposing SIM presence polling. Each and
> > every modem does it now separately. Unfortunately this seems to be
> > even trickier than PIN lock polling, at least MBM returns different
> > error codes depending on how far its own initialization has got.
> =

> My MBM seems to only detect the SIM if it is inserted during the modem
> enumeration (on USB or PCI).  If you there's no SIM during modem
> initialisation, or you extract the SIM, then inserting a new SIM is
> never detected, the modem will always return "SIM not inserted" until
> reset.

Yes, most modem don't support dynamic detect SIM. =


> =

> Caiwen, have you looked at drivers/atmodem/sim-poll.c?
> =


I have read drivers/atmodem/sim-poll.c. It looks very good. =


I have two questions.
1. It seems it depends on the invoking of ofono_sim_register to trigger the=
 SIM status
Polling. I'm not sure whether it is allowed to register the APIs(invoke ofo=
no_sim_register) =

before make sure the SIM is inserted. =

2. According to the modems that I used previously, it seems it is required =
to send profile =

to SIM before fetch the first STK command. It just my guess, I don't test i=
t. If it's wrong,
please correct me.

Here I suggest put STK initialization(fetch the SET UP MENU command) in SIM=
 state watch, =

Because it is also required to fetch SET UP MENU command after unblock PIN =
or REFRESH =

Proactive command.


Thanks!

Caiwen






--===============5406079719548815071==--

