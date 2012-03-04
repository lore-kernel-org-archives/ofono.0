Content-Type: multipart/mixed; boundary="===============3786373273617575404=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] phonesim: Add timer to set the variable with the delay
Date: Sun, 04 Mar 2012 14:56:00 -0600
Message-ID: <4F53D6E0.7060402@gmail.com>
In-Reply-To: <1330508267-8656-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3786373273617575404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 02/29/2012 03:37 AM, Oleg Zhurakivskyy wrote:
> Hello,
> =

> Please find the changes in order to permit to set variables
> with the delay (specify the delay in milliseconds):
> =

> <chat>
> 	<set name=3D"AAA" value=3D"BBB" delay=3D"30000"/>
> </chat>
> =

> This might be useful to simulate SIM PIN unlocking cases, etc.
> =

> Regards,
> Oleg
> =

> Oleg Zhurakivskyy (2):
>   phonesim: Minor reflow in SimChat::command()
>   phonesim: Add timer to set the variable with the delay
> =

>  src/phonesim.cpp |   49 ++++++++++++++++++++++++++++++++++++++-----------
>  src/phonesim.h   |   14 ++++++++++++++
>  2 files changed, 52 insertions(+), 11 deletions(-)
> =


Both patches have been applied, thanks.

Regards,
-Denis

--===============3786373273617575404==--

