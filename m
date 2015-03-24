Content-Type: multipart/mixed; boundary="===============5245478138908777825=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Small query
Date: Tue, 24 Mar 2015 09:01:58 -0500
Message-ID: <55116E56.4090909@gmail.com>
In-Reply-To: <222E70FA67D72A4FB8EEDF5AF01724ACCA1831@BGSMSX102.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5245478138908777825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ram

On 03/24/2015 05:44 AM, Kallumari Nagaraja Rao, RammohanX wrote:
> Hi,
>
> I am trying to update APN via my C code.
>
> Procedure which I am following,
>
> 1.Trying to de activate the context [ =E2=80=9CActive=E2=80=9D -> 0 ]
>
> 2.Set APN property
>
> 3.Activate the context [=E2=80=9CActive=E2=80=9D -> 1 ]
>
> I am able to get the modem, get the context.
>
> I am also able to set the APN via C code if the context is deactivated.
> Here context deactivation happened via python script under /test folder.
>
> Deactivation via c code is not happening, sometimes even if I am trying
> to deactivate ofonod daemon is activating it.

oFono only does what it is told.  Some other service must be activating =

it.  ConnMan has logic in it to re-activate contexts in case of network =

failures, etc.  You probably need to tell ConnMan not to do its thing =

while you're messing with the settings.  Or set =

org.ofono.ConnectionManager.Powered property to False.

>
> Let me know if you can pin point at any mistake. Thanks.
>

Regards,
-Denis

--===============5245478138908777825==--

