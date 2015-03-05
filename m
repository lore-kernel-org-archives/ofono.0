Content-Type: multipart/mixed; boundary="===============1399889499049409077=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: telit he910 activate-context issue
Date: Thu, 05 Mar 2015 10:07:14 -0600
Message-ID: <54F87F32.1000606@gmail.com>
In-Reply-To: <222E70FA67D72A4FB8EEDF5AF01724ACC997DF@BGSMSX102.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1399889499049409077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ram,

On 03/05/2015 05:56 AM, Kallumari Nagaraja Rao, RammohanX wrote:
> I am currently trying to get the cellular connection up via
> connman/ofono. We are using Telit HE910 device.
>
> I am currently able to do the following ,
>
> 1.Run daemon in background
>
> 2.Execute enable-modem app
>
> 3.List-contexts, set APN to required value

Are you running with root permissions?  Telit uses PPP for its context =

driver, which requires us to create a TUN/TAP device.

Can you enable AT command tracing:
export OFONO_AT_DEBUG=3D1

and run oFono with debug information enabled:
sudo ofonod -n -d

Then share this log.

>
> However, while executing =E2=80=98activate-context 0=E2=80=99 I am not ab=
le to proceed
> further.
>
> I get the following error message,
>
> =E2=80=9CDBusException: org.freedesktop.DBus.Error.NoReply: Did not recei=
ve a reply.
>
> Possible causes include: the remote application did not send a reply, the
>
> message bus security policy blocked the reply, the reply timeout expired,=
 or
>
> the network connection was broken.=E2=80=9D
>

Hard to say without an AT command trace, but sounds like the modem is =

not responding to the context activation.  Would need additional =

information to say more.

Regards,
-Denis

--===============1399889499049409077==--

