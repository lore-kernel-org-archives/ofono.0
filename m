Content-Type: multipart/mixed; boundary="===============1097345173168171669=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Outgoing call from AG fails
Date: Wed, 08 Aug 2012 12:20:49 -0500
Message-ID: <50229FF1.8080906@gmail.com>
In-Reply-To: <7B61C5BDDF8BC44292054F5CB731ED1E031D16@ep2p-exmbs2.ms.starkey.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1097345173168171669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bret,

Just a heads up: it is customary to not top-post on open source mailing =

lists.  So please don't do that in the future ;)

On 08/08/2012 07:36 AM, Bret Hassler wrote:
> It's a Vtech DS6321-3.
> https://www.bluetooth.org/tpg/EPL_Detail.cfm?ProductID=3D13096
> It provides a Handsfree Gateway service. I was wondering if it doesn't se=
nd any callsetup indicators because it is not cellular. Otherwise, you're p=
robably correct that it's not a proper device.
>

HFP 1.6 does explicitly state that callsetup is required in the case of =

an outgoing call being dialed from the HF.  There is no equivalent =

sequence diagram for the call being dialed from the AG, however this is =

mandated by TR002.  So from that standpoint you're a little bit unlucky =

in that your device is not really compliant.

Just quickly glancing at the product page, it does indicate mobile phone =

compatibility.  Maybe the HFP part is only meant when you're using it =

with a mobile network.

That said, you can try to hack around this a bit by detecting the call=3D0 =

-> call=3D1 transition regardless of callsetup, but you'd still be missing =

any sort of dialed number information, etc.  Not sure how really useful =

oFono would be for this usecase.

Regards,
-Denis

--===============1097345173168171669==--

