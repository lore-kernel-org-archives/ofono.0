Content-Type: multipart/mixed; boundary="===============4773014156002643023=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: qmi on huawei
Date: Mon, 26 Nov 2012 16:30:44 +0100
Message-ID: <1353943844.1837.2.camel@aeonflux>
In-Reply-To: <CABvLYuAOC9uTod+r_bQZaDUrMibA64y2ApCZ_AWbLa6Lk+YWXg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4773014156002643023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

> I have a Huawei E398 dongle with a qmi interface, and i'm trying to make
> ofono use the qmi interface for the gprs-context atom. I have this workin=
g,
> but depending on how i unref the qmi_device in huawei_disable, ofono
> crashes or there's have a memory leak.
> =

> The first approach i've tried is the same as in the gobi plugin.
> I call qmi_device_shutdown() from huawei_disable(), and unref the
> qmi_device from the callback.
> The problem with this is: when i unplug the device ofono crashes.
> When the device is unplugged, first  huawei_disable() is called, then
> huawei_remove(), and
> afterwards shutdown_cb() is called. At that time the ofono_modem struct is
> already freed, shutdown_cb() tries to access it and crashes.
> =

> The second approach i've tried is to unref the qmi_device directly from
> huawei_disable.
> With this approach, i see a memory leak of the qmi_service.
> qmi_gprs_context_remove() is being called from flush_atoms(). And i can s=
ee
> release_client() is being called. But the service_release_callback(), whi=
ch
> should free the service, is never being called.
> I think the request get's canceled because qmi_device_unref() is being
> called from huawei_disable(). The request is destroyed and the callback
> which should free the qmi_service is never called.
> =

> Does anyone have thoughts/ideas on how i can fix this?

actually what I am doing with the E398 is just to switch the driver to
"gobi" instead of "huawei". For testing you can just hardcode it.

diff --git a/plugins/udevng.c b/plugins/udevng.c
index afb02ca..53b12b3 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -338,6 +338,9 @@ static gboolean setup_huawei(struct modem_info *modem)
                }
        }
 =

+       qmi =3D "/dev/cdc-wdm0";
+       net =3D "wwan0";
+
        if (qmi !=3D NULL && net !=3D NULL) {
                ofono_modem_set_driver(modem->modem, "gobi");
                goto done;

The ofono.git HEAD already sets the driver, but the qmi and net
detection is not always correct. So just overwrite the values for the
device nodes and see if that works for you.

Regards

Marcel



--===============4773014156002643023==--

