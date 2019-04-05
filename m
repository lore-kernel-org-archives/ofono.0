Content-Type: multipart/mixed; boundary="===============4488070046473767256=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: support wake on SMS receive
Date: Fri, 05 Apr 2019 17:17:56 -0500
Message-ID: <a3abb549-9a64-d826-e327-bb4b67c38302@gmail.com>
In-Reply-To: <20190405161545.7394-1-JPEWhacker@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4488070046473767256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tom/Joshua,

On 04/05/2019 11:15 AM, Joshua Watt wrote:
> From: Tom Nguyen <tom.nguyen@garmin.com>
> =

> Some modems, like Quectel EC25, support waking the host platform from
> a suspend state upon an SMS reception. Current SMS handling configures
> the modem to not save incoming messages. On platforms where the modem's
> interfaces (eg, cdc-wdm, wwan, etc) disconnect on suspend and reconnect
> on resume, oFono will re-initialize. This can cause lost messages
> upon resume because the QMI indication is sent before oFono is ready.

So doesn't this also cause us to bring the modem offline when we wake up =

from resume?

> =

> Changes to support suspend/resume with wake on SMS:
> - On startup:
>    1. Configure modem to save messages to NV and notify for class NONE.
>    2. Delete all processed messages in modem memory to free space.
>    3. Get list of unread messages, then get and delete each.
> - After startup:
>    1. Process message upon event indication and delete.
>    2. Then check for possibly more messages to process.
> ---
>   drivers/qmimodem/sms.c | 338 ++++++++++++++++++++++++++++++++++-------
>   drivers/qmimodem/wms.h |  77 +++++++---
>   2 files changed, 341 insertions(+), 74 deletions(-)
> =


Anyway, just some high-level comments based on a very quick =

glance-through review:

> diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
> index 1e930396..0a85138a 100644
> --- a/drivers/qmimodem/sms.c
> +++ b/drivers/qmimodem/sms.c
> @@ -41,6 +41,14 @@ struct sms_data {
>   	uint16_t minor;
>   };
>   =

> +static struct qmi_wms_read_msg_id rd_msg_id =3D { 0 };
> +static uint8_t msg_mode =3D QMI_WMS_MESSAGE_MODE_GSMWCDMA;
> +static bool msg_chk_all;
> +static bool msg_list_chk;

You can't really do this since there might be multiple drivers active in =

a given oFono process. E.g. multiple QMI modems online at the same time =

(and yes, people do this today).  So any state data must be allocated as =

part of the driver data.

Regards,
-Denis

--===============4488070046473767256==--

