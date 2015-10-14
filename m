Content-Type: multipart/mixed; boundary="===============6269420215423686252=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/9] Rilmodem driver
Date: Wed, 14 Oct 2015 10:46:27 -0500
Message-ID: <561E78D3.4000603@gmail.com>
In-Reply-To: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6269420215423686252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 10/13/2015 11:07 AM, Alfonso Sanchez-Beato wrote:
> This patch series implements the rilmodem driver, which uses Android's
> radio interface layer (RIL, part of the Android HAL) to interact with
> the modem.
>
> The driver is almost feature-complete with some exceptions, being CBS
> and SAT the most prominent.
>
> Besides the driver, the patches include the following plugins:
> * ril.c: Plugin for Android modems
> * infineon.c: Plugin for infineon modems, which are a variant of the ril
>    modem
> * rildev: plugin that creates ril-type modems using environment
>    variables
>
> Finally, the patches contain some minor modifications of the core code
> to export a couple of enumerations used by the driver.
>
> The driver is used by Ubuntu for Phones and Sailfish and is quite stable
> at the moment.
>
> Alfonso Sanchez-Beato (5):
>    include: Add definitions for phone number types
>    infineon: Definitions for infineon modem
>    infineon: Plugin for infineon modems
>    rildev: plugin that creates ril-type modems
>    build: Add rilmodem to the build
>
> Tony Espy (4):
>    src: make bearer/operator enums public
>    gril: Library to communicate with rild
>    rilmodem: driver for Android modems
>    ril: Plugin for Android modems
>

All applied, now lets start cleaning it up :)

Regards,
-Denis


--===============6269420215423686252==--

