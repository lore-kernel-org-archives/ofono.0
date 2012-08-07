Content-Type: multipart/mixed; boundary="===============1497251973687526672=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Outgoing call from AG fails
Date: Tue, 07 Aug 2012 08:17:02 -0500
Message-ID: <5021154E.6020305@gmail.com>
In-Reply-To: <7B61C5BDDF8BC44292054F5CB731ED1E031CBF@ep2p-exmbs2.ms.starkey.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1497251973687526672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bret,

On 08/07/2012 04:58 PM, Bret Hassler wrote:
> I have a handsfree unit with ofono connecting to a VTech landline phone
> as audio gateway. On outgoing calls, the only HFP notification for the
> call is only a +CIEV: call status,1.
>

call indicator should not be going to 1 without first having the =

callsetup indicator going to 1.  Doesn't sound like this is a proper HFP =

device.  What type of device is this?

> drivers/hfpmodem/voicecall.c: ciev_call_notify() will not do anything if
> without a call already created. The VTech phone also returns error to
> AT+CLCC command.
>
> I am thinking to create the ofono_call in drivers/hfpmodem/voicecall.c:
> ciev_call_notify() if no call has been created. However, this might have
> big impacts other phones. Specifically, does =E2=80=9C+CIEV: call status,=
1=E2=80=9D get
> emitted outside of standard phone calls, such as for alarms or
> notifications with some phones? Any thoughts on this?
>

Instead of hcidump you might want to use the built-in oFono AT logging. =

  See HACKING for details.

Regards,
-Denis

--===============1497251973687526672==--

