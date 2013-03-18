Content-Type: multipart/mixed; boundary="===============7806331465706181084=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v2 11/13] dundee: Add support for driver connect
Date: Mon, 18 Mar 2013 09:38:47 +0100
Message-ID: <5146D297.6020207@monom.org>
In-Reply-To: <1363267974-13518-12-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7806331465706181084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

The series breaks to compile at this patch.

On 03/14/2013 02:32 PM, Paulo Borges wrote:
> This patch glues together the dundee driver interface with the
> D-Bus Profile1 interface.
> =

> When the dundee driver requests a connection, it will call the
> Device1's ConnectProfile.
> ---
>   dundee/bluez5.c |    7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> =

> diff --git a/dundee/bluez5.c b/dundee/bluez5.c
> index 82bb7aa..2d10e5a 100644
> --- a/dundee/bluez5.c
> +++ b/dundee/bluez5.c
> @@ -114,7 +114,12 @@ static void bluetooth_device_destroy(gpointer user_d=
ata)
>   static void bluetooth_device_connect(struct dundee_device *device,
>   			dundee_device_connect_cb_t cb, void *data)
>   {
> -	DBG("");
> +	struct bluetooth_device *bt_device =3D dundee_device_get_data(device);
> +
> +	DBG("%s", bt_device->path);
> +
> +	bt_connect_profile(ofono_dbus_get_connection(), bt_device->path,
> +						DUN_DT_UUID, NULL, NULL);
>   }
>   =

>   static void bluetooth_device_disconnect(struct dundee_device *device,
> =


HEAD is now at 1198ace dundee: Add support for driver connect
make --no-print-directory all-am
  CC       dundee/bluez5.o
dundee/bluez5.c: In function =E2=80=98bluetooth_device_connect=E2=80=99:
dundee/bluez5.c:122:7: error: =E2=80=98DUN_DT_UUID=E2=80=99 undeclared (fir=
st use in this function)
dundee/bluez5.c:122:7: note: each undeclared identifier is reported only on=
ce for each function it appears in
make[1]: *** [dundee/bluez5.o] Error 1
make: *** [all] Error 2
Broke on 1198aceb147e2839a86b5f5c1cf65556d3d8fa2d


Should that be DUN_UUID?


cheers,
daniel

--===============7806331465706181084==--

