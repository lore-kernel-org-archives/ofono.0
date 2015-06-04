Content-Type: multipart/mixed; boundary="===============4692386574318086072=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] Connecting a phone with mpty call does not trigger
 CLCC polling
Date: Thu, 04 Jun 2015 16:19:14 -0500
Message-ID: <5570C0D2.8080504@gmail.com>
In-Reply-To: <1433352350-10595-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4692386574318086072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 06/03/2015 12:25 PM, Kuba Pawlak wrote:
> If there is more then one active or held call, we are in mpty calls.
> We won't get indicator update if any of them is released by CHLD=3D1x.
> So we have to poll it.
> ---
>   drivers/hfpmodem/voicecall.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============4692386574318086072==--

