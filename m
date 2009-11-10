Content-Type: multipart/mixed; boundary="===============4835156226875473906=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] Work around Palm Pre SIM file reading quirk.
Date: Tue, 10 Nov 2009 09:19:45 +0100
Message-ID: <1257841185.3024.17.camel@violet>
In-Reply-To: <1257834610-22409-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4835156226875473906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,

> I'm not sure if MSM is not a too generic name but it seems the G1's
> Qualcomm MSM suffers from similar problems.

<snip>

> diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
> index d88444f..5c2613c 100644
> --- a/drivers/atmodem/vendor.h
> +++ b/drivers/atmodem/vendor.h
> @@ -23,4 +23,5 @@ enum ofono_vendor {
>  	OFONO_VENDOR_GENERIC =3D 0,
>  	OFONO_VENDOR_HTC_G1,
>  	OFONO_VENDOR_CALYPSO,
> +	OFONO_VENDOR_MSM,
>  };

call it OFONO_VENDOR_QCOM_MSM to be clear that it is Qualcomm specific,
but again we might rename all of these anyway at some point with quirk
names that actually clearly show what they are quirking.

Regards

Marcel



--===============4835156226875473906==--

