Content-Type: multipart/mixed; boundary="===============2583067675975869577=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] huawei, util: Fix a couple of implicit enum conversions
Date: Tue, 22 Dec 2020 10:33:24 -0600
Message-ID: <3d7e6109-11f6-37cc-946f-c26320835c40@gmail.com>
In-Reply-To: <20201220111827.2119273-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2583067675975869577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 12/20/20 5:18 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> GCC 10 warns about a couple of implicit conversions;
> =

> huawei: Member from the incorrect enum was returned,
> both had the value 0, so the code would still work.
> =

> drivers/huaweimodem/radio-settings.c: In function =E2=80=98band_gsm_from_=
huawei=E2=80=99:
> drivers/huaweimodem/radio-settings.c:107:10: error: implicit conversion f=
rom =E2=80=98enum ofono_radio_band_umts=E2=80=99 to =E2=80=98enum ofono_rad=
io_band_gsm=E2=80=99 [-Werror=3Denum-conversion]
>    107 |   return OFONO_RADIO_BAND_UMTS_ANY;
> =

> util: smsutil and util has an enum each for representing
> the same thing; The SMS alphabet. They share the same
> values, so an explicit type cast makes GCC happy.
> =

> src/smsutil.c: In function =E2=80=98sms_text_prepare_with_alphabet=E2=80=
=99:
> src/smsutil.c:3594:8: error: implicit conversion from =E2=80=98enum sms_a=
lphabet=E2=80=99 to =E2=80=98enum gsm_dialect=E2=80=99 [-Werror=3Denum-conv=
ersion]
>   3594 |        alphabet, &used_locking,
> ---
>   drivers/huaweimodem/radio-settings.c | 2 +-
>   src/smsutil.c                        | 5 ++++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> =


I split this into two commits and applied.  Thanks!

Regards,
-Denis

--===============2583067675975869577==--

