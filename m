Content-Type: multipart/mixed; boundary="===============5055744025287380381=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 06/10] ublox: determine gprs-context driver from network
 interface
Date: Fri, 19 Jul 2019 01:43:54 -0500
Message-ID: <dd941e54-84f8-1129-972f-02cec8eb557f@gmail.com>
In-Reply-To: <20190718102314.28094-6-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5055744025287380381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 7/18/19 5:23 AM, Jonas Bonn wrote:
> Some u-blox devices present a USB network class device for data and some
> just switch to PPP on (one of) the communication channel(s).  Whether
> the atmodem or ubloxmodem gprs-context driver should be used depends on
> whether or not the network interface is present; check this condition
> directly when deciding which driver to us.
> ---
>   plugins/ublox.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> =


Patches 6-10 applied, thanks.

Regards,
-Denis


--===============5055744025287380381==--

