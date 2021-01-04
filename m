Content-Type: multipart/mixed; boundary="===============0800345254325397117=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Quectel EC200T USB: Problems with context activation
Date: Mon, 04 Jan 2021 11:43:09 -0600
Message-ID: <735d4c09-ee6f-73e1-237f-5ce57abb8796@gmail.com>
In-Reply-To: <CAFiQ676_iC_LYet=Dg3gH0Ci2_-VEJc=gnKycQuBuwaDWVCYpQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0800345254325397117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On 1/2/21 3:52 AM, Sergei Golubtsov wrote:
> Hi Denis,
> =


Happy New Year.  Apologies for the late response, I was in holiday mode.

>     The log from my previous message clearly shows that the problem is th=
at the
>     modem stopped escaping control characters (<0x20) with 0x7d when phas=
e 2 had
>     begun. Apparently pppd is ok with this behaviour. Am going to compare=
 the
>     HLDC=C2=A0frame parsers=C2=A0in pppd and ofono. Is it a modem bug or =
an ofono missing
>     feature? Any help will be appreciated.
> =

> I have found the problem. ofono does not apply ACCM, which is proposed by=
 the =


So you're on the right track, but I think you're coming to the wrong conclu=
sion. =

  Things are a bit more subtle than that.

> DCE in a configuration request. The EC200 Quectel modem uses ACCM =3D 0x0=
0000000 =

> in the authentication phase and ofono ACK such configuration but does not=
 apply =

> configuration options. That is why ofono silently=C2=A0drops some frames =
from the DCE =


No, this is not correct.   oFono does honor the ACCM sent by the modem.  Th=
is =

happens in lcp_rcr().   Look around ppp_lcp.c:321 or so.  We apply the opti=
ons =

just prior to sending the ack.

Remember, there are two ACCMs, the transmit and the receive.  Refer to RFC =
1662, =

Section 7.1:

"Each end of the asynchronous link maintains two Async-Control-Character-Ma=
ps. =

The receiving ACCM is 32 bits, but the sending ACCM may be up to 256 bits. =
 This =

results in four distinct ACCMs, two in each direction of the link."

The receive ACCM is the issue here.  RFC 1662 also says:
"For asynchronous links, the default receiving ACCM is 0xffffffff.  The def=
ault =

sending ACCM is 0xffffffff, plus the Control Escape  and Flag Sequence =

characters themselves, plus whatever other outgoing characters are flagged =
(by =

prior configuration) as likely to be intercepted."

GAtPPP basically doesn't want or need to re-negotiate the default ACCM, hen=
ce we =

do not send an ACCM to the peer, expecting it to use the defaults.  See =

lcp_generate_config_options().  REQ_OPTION_ACCM is never set.  What this me=
ans =

is that when the peer acks our options and we call lcp_rca in =

pppcp_process_configure_ack(), the ACCM option is not present.  Hence the c=
ode =

for setting the ACCM in lcp_rca() is never triggered.

So I suspect what is happening is that your Quectel modem assumes that not =

requesting the ACCM means having a zero ACCM instead of the RFC-mandated de=
fault.

So far, all modems on this planet have honored the default properly...

> in phase 2 and does not answer to packets because the FCS (CRC) of packet=
s does =

> not match the value calculated by ofono. I have sent a patch, which=C2=A0=
solves the =

> problem.
> I am concerned about two things:
> 1. Did I choose the right place to insert the configuration options appli=
cation =

> code?

So you have two options for fixing this:
   - Make GAtPPP negotiate a default ACCM in all cases
   - Override the negotiated ACCM (using g_at_hdlc_set_recv_accm for your =

particular modem.

> 2. ACCM is for asynchronous links only. Does ofono support other links? I=
f so we =

> must check the link type before applying the ACCM configuration option as =

> suggested in RFC 1812 <https://www.freesoft.org/CIE/RFC/1812/index.htm>=
=C2=A03.3.5.2.
> =


We only support PPP over serial ports or emulated serial ports, which have =
to =

use ACCM.  I'm not aware of any other possibilities.

Regards,
-Denis
--===============0800345254325397117==--

