Content-Type: multipart/mixed; boundary="===============7415249201112871096=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PPP connection to a private APN
Date: Fri, 02 Aug 2013 11:00:19 -0500
Message-ID: <51FBD793.8050001@gmail.com>
In-Reply-To: <CAMtf1D9M+Eg=vUop=3r9H6RAjqpTuFFu_WQ0P=SH6FPJyGe5Gw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7415249201112871096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

On 08/02/2013 10:31 AM, Etienne Mabille wrote:
> Hi everyone,
>
> I am forced to work with version 1.3 of oFono and I want to setup a ppp
> connection on a private APN.
> It works well on a public APN but not on the private one. I looked at
> the debug trace and it seems like oFono doesn't give the username and
> password anywhere in the AT commands.
> Is this function possible ? If so, does anyone know when this feature
> was added so I can add a patch to my version ?
>

Your subject mentions a 'PPP' connection.  So I assume you're using a =

modem which uses PPP.  If so, then the user/password exchange is done =

over the PPP link and not AT commands.  You will have to debug the PPP =

connection in order to understand what fails.

The gatchat library actually has a nice tool that might help.  It uses =

the oFono internal PPP implementation and can make basic context =

activations.  See gatchat/gsmdial.c for reference.

The tool also supports PPPdump file output (use --pppdump option to set =

a filename).  You can then view the detailed transaction log with =

wireshark or another protocol analyzer.

Regards,
-Denis


--===============7415249201112871096==--

