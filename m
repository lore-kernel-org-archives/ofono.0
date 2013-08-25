Content-Type: multipart/mixed; boundary="===============6431456942637001402=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Recommendation for a good Modem
Date: Sun, 25 Aug 2013 00:12:39 -0500
Message-ID: <52199247.9010905@gmail.com>
In-Reply-To: <CAGws1TsTzbvvVpnTNyxeq-a8z2JBS_7MCd=UdqiXaovXXY1O7g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6431456942637001402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On 08/26/2013 04:58 AM, Markus Hubig wrote:
> Hi @all,
>
> I'm looking for a GPRS/UMTS modem for a small embedded linux
> appliance I'm building. I want to use ofono to handle the modem.
>
> First I thought about the Telit GC864, but unfortunately this seems
> to be not supported by ofono (at least not out of the box) ...
>

How different is the GC864 from say UC864?  Supporting the GC864 might =

be as simple as tweaking some parameters inside the relevant modem =

detection plugin.

> Is there a good GPRS/UMTS modem you would recommend?
>
> My requirements are:
>
> - MUST: Out-of-the box supported by ofono
> - MUST: Connector / No BGA
> - MAY: SimCard holder integrated.
> - MAY: UMTS
> - MAY: GPS Option
>

You will probably need to look into modem offerings from Cinterion, =

Option, Telit, Sierra and SimCom.  All have some sort of support inside =

oFono to varying degrees, but likely you will still need to do some =

integration work.

There may be others who can give a more concrete recommendation.

Regards,
-Denis

--===============6431456942637001402==--

