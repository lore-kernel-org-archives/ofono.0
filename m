Content-Type: multipart/mixed; boundary="===============4810674060815113597=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/7] netmon: add OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP}
Date: Wed, 30 Nov 2016 09:27:42 -0600
Message-ID: <583EEFEE.6050506@gmail.com>
In-Reply-To: <1480509105-17934-2-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4810674060815113597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Djalal,

On 11/30/2016 06:31 AM, Djalal Harouni wrote:
> Add more ofono netmon info types that will be served through the netmon
> interface. The main user of this now will be the ublox modem.
>
> RSCP: Received Signal Code Power
> ECN0: Received Energy Ratio
> RSRQ: Reference Signal Received Quality
> RSRP: Reference Signal Received Power
>
> Patches using these types to follow.
> ---
>   include/netmon.h | 4 ++++
>   1 file changed, 4 insertions(+)
>

I tweaked the commit header and applied this patch.  Thanks!

Regards,
-Denis


--===============4810674060815113597==--

