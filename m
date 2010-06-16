Content-Type: multipart/mixed; boundary="===============5145186109172806460=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 10/12] stk: Add parser for timing advance objects
Date: Thu, 17 Jun 2010 01:19:06 +0200
Message-ID: <AANLkTilCbhxMpJeulCWXzveOWEeUnRoZVR3BwfblqyjG@mail.gmail.com>
In-Reply-To: <1276422202-16240-10-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5145186109172806460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 13 June 2010 11:43, Yang Gu <yang.gu@intel.com> wrote:
> +enum stk_me_status {
> + =C2=A0 =C2=A0 =C2=A0 STK_ME_STATUS_IDLE =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00x00,
> + =C2=A0 =C2=A0 =C2=A0 STK_ME_STATUS_NOT_IDLE =3D =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x01
> +};
> +
> =C2=A0/* For data object that only has a byte array with undetermined len=
gth */
> =C2=A0struct stk_common_byte_array {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char *array;
> @@ -671,6 +676,18 @@ struct stk_timer_value {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char second;
> =C2=A0};
>
> +/* Defined in TS 31.111 Section 8.46 */
> +struct stk_timing_advance {
> + =C2=A0 =C2=A0 =C2=A0 ofono_bool_t has_value;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char status;

Why change the status to char here?  I think using an enum here is
nicer because it gives a hint to users about what values are expected
and the compiler can emit warnings if needed.

Regards

--===============5145186109172806460==--

