Content-Type: multipart/mixed; boundary="===============2015050180255611180=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 0/3] ublox device initialisation
Date: Wed, 25 Sep 2019 21:28:16 -0500
Message-ID: <f81c1f5a-1bad-ed6b-d484-328eb31c923f@gmail.com>
In-Reply-To: <20190925043507.29892-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2015050180255611180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 9/24/19 11:35 PM, Jonas Bonn wrote:
> Changed in v3:
> - consolidate device closing into a common helper
> - remove timeout in disable function
> =

> Jonas Bonn (3):
>    ublox: consolidate teardown in common function
>    ublox: use common close_devices when modem disabled
>    ublox: rework device initialization sequence
> =

>   plugins/ublox.c | 155 ++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 118 insertions(+), 37 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============2015050180255611180==--

