Content-Type: multipart/mixed; boundary="===============9211155891440864681=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2] huawei: follow sim state change notifications
Date: Tue, 25 May 2010 11:15:42 +0200
Message-ID: <1274778942.27220.125.camel@localhost.localdomain>
In-Reply-To: <20100525084857.1105.91785.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9211155891440864681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> With Huawei E1552 I got sim busy errors when I plugged in the modem
> and ofono was already running:
> =

> May 24 17:02:04 tukki ofonod[7619]: > AT+CRC=3D1\r
> May 24 17:02:04 tukki ofonod[7619]: < \r\n+CME ERROR: SIM busy\r\n
> May 24 17:02:04 tukki ofonod[7619]: > AT+CLIP=3D1\r
> May 24 17:02:04 tukki ofonod[7619]: < \r\n+CME ERROR: SIM busy\r\n
> =

> Fix this by following sim state changes with ^SIMST notification and
> only enable modem after SIM is ready. In case SIM is already ready
> and we miss the notification for some reason, also use AT^SYSINFO
> to check the state during enable phase.
> =

> Also change huawei_enable() to return -EINPROGRESS to make sure that
> ofono modem is not powered too early. I believe this was a bug.
> ---
> =

>  plugins/huawei.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 files changed, 73 insertions(+), 3 deletions(-)

patch has been applied. Thanks.

> +static void huawei_simst_notify(GAtResult *result, gpointer user_data)
> +{

I did some minor cleanups since huawei_ prefix should only be used for
functions referenced in driver callbacks. Not the ones used for GAtChat
callbacks. However that is so not obvious that I fixed it by myself ;)

Regards

Marcel



--===============9211155891440864681==--

