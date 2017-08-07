Content-Type: multipart/mixed; boundary="===============4170664333024410806=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] drivers/qmimodem: don't change the RAT when registering
 to an operator
Date: Mon, 07 Aug 2017 13:50:56 -0500
Message-ID: <3bad5157-3f88-028c-4e8e-a5e164aab6fa@gmail.com>
In-Reply-To: <20170725131749.17831-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4170664333024410806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 07/25/2017 08:17 AM, Alexander Couzens wrote:
> When registering to an operator ofono uses the old RAT.
> In the case the modem is not connected to any network, this would use
> QMI_NAS_NETWORK_RAT_NONE which results in the error OP_DEVICE_UNSUPPORTED.
>
> Use QMI_NAS_NETWORK_RAT_NO_CHANGE instead to not define any preference.
> ---
>  drivers/qmimodem/nas.h                  | 1 +
>  drivers/qmimodem/network-registration.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============4170664333024410806==--

