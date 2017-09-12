Content-Type: multipart/mixed; boundary="===============6621564235082252516=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: nokia-modem (N900) not detected after migration to udevng
Date: Tue, 12 Sep 2017 09:51:16 +0200
Message-ID: <ba3c362b-2bd4-0c4d-0c01-bdaed7ad53c3@southpole.se>
In-Reply-To: <20170911195453.GA3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6621564235082252516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/11/2017 09:54 PM, Clayton Craft wrote:
> On Mon, Sep 11, 2017 at 01:49:05PM -0500, Denis Kenzior wrote:
>> If Jonas or you want to combine these into a single proper patch, =

>> I'll take it up.
>
>
> Challenge accepted! Combined patch below.

Hmm... I suspect Denis wants a 'proper patch' that he can merge into git =

directly.  I'll take care of that today.
/Jonas

>
> -Clayton
>
>
>
> plugins/udevng.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 518eda8e..a4b99aa4 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1013,8 +1013,6 @@ static gboolean setup_isi_serial(struct =

> modem_info* modem)
>     if (value)
>         ofono_modem_set_integer(modem->modem, "Address", atoi(value));
>
> -    ofono_modem_set_string(modem->modem, "Device", info->devnode);
> -
>     return TRUE;
> }
>
> @@ -1325,7 +1323,7 @@ static void add_serial_device(struct udev_device =

> *dev)
>
>     devnode =3D udev_device_get_devnode(dev);
>
> -    if (!syspath || !devname || !devpath || !devnode)
> +    if (!syspath || !devpath)
>         return;
>
>     modem =3D g_hash_table_lookup(modem_list, syspath);
> @@ -1337,7 +1335,7 @@ static void add_serial_device(struct udev_device =

> *dev)
>         modem->type =3D MODEM_TYPE_SERIAL;
>         modem->syspath =3D g_strdup(syspath);
>         modem->devname =3D g_strdup(devname);
> -        modem->driver =3D g_strdup("legacy");
> +        modem->driver =3D g_strdup(driver);
>
>         g_hash_table_replace(modem_list, modem->syspath, modem);
>     }
> @@ -1357,7 +1355,7 @@ static void add_serial_device(struct udev_device =

> *dev)
>     info->subsystem =3D g_strdup(subsystem);
>     info->dev =3D udev_device_ref(dev);
>
> -    modem->devices =3D g_slist_append(modem->devices, info);
> +    modem->serial =3D info;
> }
>
> static void add_device(const char *syspath, const char *devname,



--===============6621564235082252516==--

