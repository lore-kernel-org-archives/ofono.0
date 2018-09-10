Content-Type: multipart/mixed; boundary="===============8423344834464515584=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] udev:fix seg fault in case of vid and pid is NULL
Date: Mon, 10 Sep 2018 11:05:33 -0500
Message-ID: <0c70d052-5937-0a9d-3f52-f20f12343aec@gmail.com>
In-Reply-To: <1536554521-22796-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8423344834464515584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anirudh,

On 09/09/2018 11:42 PM, "Anirudh Gargi anirudh.gargi"@intel.com wrote:
> From: Anirudh Gargi <anirudh.gargi@intel.com>
> =

> In some case linux report 'driver' as valid yet vid and pid as NULL.
> Adding NULL check to prevent seg fault.
> =

> Log:
> ofonod[23829]: plugins/udevng.c:udev_start()
> ofonod[23829]: plugins/udevng.c:enumerate_devices()
> ofonod[23829]: plugins/udevng.c:check_usb_device() hub [1d6b:0002]
> ofonod[23829]: plugins/udevng.c:check_usb_device() usb [1d6b:0002]
> ofonod[23829]: plugins/udevng.c:check_usb_device() usbhid [03f0:034a]
> ofonod[23829]: plugins/udevng.c:check_usb_device() usbhid [03f0:034a]
> ofonod[23829]: plugins/udevng.c:check_usb_device() usb [1d6b:0002]
> ofonod[23829]: plugins/udevng.c:check_usb_device() cdc_acm [(null):(null)]
> ofonod[23829]: Aborting (signal 11) [./src/ofonod]
> ---
>   plugins/udevng.c | 3 +++
>   1 file changed, 3 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============8423344834464515584==--

