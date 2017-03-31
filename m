Content-Type: multipart/mixed; boundary="===============7511900448152785120=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC hwdb v1 11/28] udevng (hso): remove impossible condition
Date: Fri, 31 Mar 2017 17:51:16 -0500
Message-ID: <d1b7ccc0-f47b-4452-cae6-02d268901a6d@gmail.com>
In-Reply-To: <20170330205309.25850-12-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7511900448152785120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/30/2017 03:52 PM, Jonas Bonn wrote:
> The hso driver setup function tests for the devnode beginning with "hso"
> in order to detect the network interface.  Since the devnode will always
> begin with "/dev", this condition will never be fulfilled.

That's definitely incorrect.  setup_hso will receive both ttys and =

network devices.  ttys will start with /dev/, but network devices are =

not.  This change would break all option devices with a high speed =

interface.

>
> Given that the 'net' variable never gets set, we could just remove it.
> However, leaving it there for now might be reminder to someone to figure
> out how to set it in case it's actually needed.  That said, this test
> has been in the code since 2011 and, presumably, nobody's noticied so
> this modem might not be something that anybody actually uses anymore.

'net' definitely gets set.  I just tested it on an Option 452 and it =

works just fine.

> ---
>  plugins/udevng.c | 3 ---
>  1 file changed, 3 deletions(-)
>

Regards,
-Denis


--===============7511900448152785120==--

