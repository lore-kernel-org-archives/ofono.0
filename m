Content-Type: multipart/mixed; boundary="===============7096163651250486166=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Wed, 04 Mar 2020 10:10:56 -0600
Message-ID: <7c96764b-1885-a697-3fbb-76677d7e4183@gmail.com>
In-Reply-To: <20200302163136.19369-1-nick83ola@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7096163651250486166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicola,

On 3/2/20 10:31 AM, Nicola Lunghi wrote:
> if the mobile provider information database has multiple apn settings for=
 the
> same operator, ofono was throwing an error and creating a default internet
> context with an empty apn.
> =

> This patch will instead allow the automatic creation of multiple context
> allowing the user to pick one of the default via connman.

I still maintain this is a horrible idea.  Yes it is a nice workaround =

if you don't have a proper provisioning database, but not something I'd =

use in production.

What I can do is allow this to be configurable via some config file or =

environment variable (and off by default).

> =

> Connman supports multiple cellular context so no issue there.
> =

> Previously proposed by Martin Hundeb=C3=83=C2=B8ll here:
> https://lists.ofono.org/hyperkitty/list/ofono(a)ofono.org/thread/2SC46PH5=
CWT3A3HTHGUKUUVI3QDYIL73/#7B6CPARJQMZUBQUPXBJMAOXZY4RW2L3D
> =

> And tested by Nicola Lunghi with connman 1.37
> =

> Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>

No SoB please.

> ---
>   plugins/provision.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Regards,
-Denis
--===============7096163651250486166==--

