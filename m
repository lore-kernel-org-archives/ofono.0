Content-Type: multipart/mixed; boundary="===============5758590796837953433=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix crash on repairing a Device.
Date: Sun, 12 Jul 2015 21:19:56 -0500
Message-ID: <55A3204C.20407@gmail.com>
In-Reply-To: <1436540881-20121-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5758590796837953433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 07/10/2015 10:08 AM, Kuba Pawlak wrote:
> It may happen that a Device object is unpaired an paired again
> without being removed from DBus. This in turn triggers second
> modem object to be created, but not fully initialized.
> If this modem object is used, oFono will crash.
> ---
>   plugins/hfp_hf_bluez5.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============5758590796837953433==--

