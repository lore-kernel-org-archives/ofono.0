Content-Type: multipart/mixed; boundary="===============3628310064741330314=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: [PATCH v2] Add CDMA extension tasks
Date: Thu, 26 Aug 2010 04:52:15 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE8056A6CC2@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE8056A6C4A@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3628310064741330314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

I'd like remind you that please use plaint text and follow the mail rule of=
 ofono.
(I have ever make the same mistake several days ago :) ).

> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of Jeevaka Prabu Badrappan
> Sent: Wednesday, August 25, 2010 5:46 PM
> To: ofono(a)ofono.org,
> =

> Subject: Re: [PATCH v2] Add CDMA extension tasks
> =

> Hi Caiwen,
> =

> ---
> =C2=A0TODO | =C2=A0 76
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 files changed, 76 insertions(+), 0 deletions(-)
> =

> diff --git a/TODO b/TODO
> index a97f076..b159c07 100644
> --- a/TODO
> +++ b/TODO
> @@ -614,3 +614,79 @@ Miscellaneous
> =

> =C2=A0 Priority: Low
> =C2=A0 Complexity: C4
> +
> +
> +CDMA/EVDO
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Extend modem interface with a 'Type' property to indicate the modem
> type.
> +
> + =C2=A0Priority: High
> + =C2=A0Complexity: C1
> +
> +- Add UIM support. UIM support change pin, enter pin, reset pin, set
> pin lock, get pin lock setting,
> + =C2=A0get pin remain retry time, and get information that stored in UIM,
> include MCC/MNC, ruimid, IMSI,
> + =C2=A0MDN, PRL version etc.
> +
> + =C2=A0Priority: High
> + =C2=A0Complexity: C4
> +
> +- Add CDMA SMS support, include broadcast short message. In CDMA,
> broadcast short message is
> + =C2=A0a kind of SMS. CDMA SMS manager atom will support SMS sending and
> receiving. Many CDMA modems
> + =C2=A0may only support text mode and other modems only support PDU mode.
> In CDMA SMS manage atom will
> + =C2=A0define a data structure that contain every parameters and
> subparameters defined in C.S0015. In
> + =C2=A0relative modem driver plug-in, the relevant fields(text mode) or
> PDU(may be manufacturer
> + =C2=A0specific) will be parsed and filled into the data structure, then=
 it
> will be proceed in CDMA
> + =C2=A0SMS manager atom.
> +
> + =C2=A0Special SMSs, SCPT, CATPT and voice mail notification(VMN)(please
> refer to C.S0015 section 4.3.8,
> + =C2=A04.3.9, 4.3.5)will be processed in ofono, and other messages with a
> port number (include WAP push
> + =C2=A0message) will be processed by external plug-ins. CDMA SMS manager
> atom offer an API for register
> + =C2=A0external plug-in.
> +
> + =C2=A0Priority: High
> + =C2=A0Complexity: C8
> +
> +- Add CDMA voice call support. CDMA voice call will support
> originate/end/hold a call,
> + =C2=A0transfer a call, 3WC(three-way calling), conference call and DTMF.
> For a voice call, can get
> + =C2=A0its status, CLI and ending result(if it is end).
> +
> + =C2=A0Priority: High
> + =C2=A0Complexity: C6
> +
> +- Add CDMA Data connection support. CDMA data connection manager
> support start/end a data connect
> + =C2=A0according to the settings from other module(upper layer or
> ConnMan)and get/set Qos.
> +
> + =C2=A0Priority: High
> + =C2=A0Complexity: C4
> +
> +- Add SIM/UIM data access support. Add a card atom, it will support
> read/update/delete/add conatact
> + =C2=A0add SMS in SIM/UIM card.
> +
> + =C2=A0Priority: High
> + =C2=A0Complexity: C6
> +
> +- Add CTCC modem driver. The CTCC modem driver will totally obey
> <China Telecom CDMA terminal
> + =C2=A0requirement specification -- 1xEV-DORevA Data Terminal AT command
> Interface fascicule V1.1>
> +
> + =C2=A0Priority: High
> + =C2=A0Complexity: C10
> +
> --
> 1.7.0.4
> =

> It looks like you are providing new dbus interface for UIM(SimManager),
> DataConnection(DataConnectionManager), etc...

You know, GSM and CDMA is very different in some features. It is impossible=
 keep
All the APIs the same. We will try our best to keep the D-bus APIs the same=
 as ofono =

current APIs.
If I have different idea about ofono current APIs. I will pop up and discus=
s in
IRC or this mail list. Before, implement a CDMA atom, I will post the propo=
sed APIs.
It is very thankful if you pop up your suggestion and concern.

UIMManager APIs will be the same as SimManager. I just post my thinking abo=
ut the =

Current APIs, you know, generally, R-UIM follow 3GPP TS 51.011 too. Its fun=
ction is =

the same as SIM. =


> If so, what is the need for providing a new interface, why can't we
> extend the existing SimManager, DataConnectionManager etc... to support
> CDMA usecases.
> If we provide new interfaces, there could be changes needed in upper
> layers for eg: ConnMan.
> =

> Could you clarify?

I think some changes are unavoidable. What we can do is try to minimize it. =


For ConnMan, if you'd like support multi-data connection. Maybe you should =
implement =

a plug-in for CDMA/Evdo, just like we you do for WIFI or other data connect=
ion.


Best regards,
Caiwen

--===============3628310064741330314==--

