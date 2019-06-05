Content-Type: multipart/mixed; boundary="===============5046730292121850201=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4] qmimodem: change msg class none to store/notify
Date: Wed, 05 Jun 2019 14:55:37 -0500
Message-ID: <1d808d21-4c97-d2d6-f348-78da73a2ea5f@gmail.com>
In-Reply-To: <1530553207.4266.1559751983478@wamui-aurora.atl.sa.earthlink.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5046730292121850201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On 06/05/2019 11:26 AM, Tom Nguyen wrote:
> Change message class none configuration from directly delivering a new
> message in the event indication to storing it in the modem's NV then
> sending an event indication identifying the new message. Also, add
> checking for stored, unread messages at boot up.
> =

> This fixes a scenario where the modem powers on, automatically
> connects to the network, receives a message, and sends an indication
> before oFono has fully initialized. Now, the message is saved and
> retrieved after initialization.
> =

> This also helps with suspend/resume on platforms where the modem,
> supports waking the host CPU upon SMS reception. And, the platform
> design limitation is that the modem's interfaces (eg, cdc-wdm, wwan,
> etc) disconnect on suspend and reconnect on resume. This causes oFono
> to re-initialize and miss the message indication because it was sent
> before oFono is ready. Now, the wake up message is saved and retrieved
> after initialization.
> ---
>   drivers/qmimodem/sms.c | 367 ++++++++++++++++++++++++++++++++++++++++++=
-------
>   drivers/qmimodem/wms.h |  77 ++++++++---
>   2 files changed, 376 insertions(+), 68 deletions(-)
> =


Went ahead and applied.  I did have:
drivers/qmimodem/sms.c: In function =E2=80=98get_msg_list_cb=E2=80=99:
drivers/qmimodem/sms.c:483:20: error: unused variable =E2=80=98param=E2=80=
=99 =

[-Werror=3Dunused-variable]
   struct qmi_param *param;


So I amended the commit to squash that.

Regards,
-Denis

--===============5046730292121850201==--

