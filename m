Content-Type: multipart/mixed; boundary="===============6594964030018412988=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp_hf_bluez5: Add SLC establishment procedure
Date: Wed, 23 Jan 2013 17:29:31 -0600
Message-ID: <5100725B.5020507@gmail.com>
In-Reply-To: <1358982509-8685-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6594964030018412988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 01/23/2013 05:08 PM, Vinicius Costa Gomes wrote:
> When receiving a NewConnection call from BlueZ, initiates the Service
> Level Connection using the received file descriptor. The HFP modem
> sub-components (devinfo, voicecall, netreg, handsfree and callvolume)
> are created at this point.
> ---
>
> Now that we don't change how hfp_slc_info is allocated, this is the last
> patch in the "HFP Service Level Connection establishment" series.
>
>
>   plugins/hfp_hf_bluez5.c | 175 +++++++++++++++++++++++++++++++++++++++++=
+++++--
>   1 file changed, 169 insertions(+), 6 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============6594964030018412988==--

