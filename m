Content-Type: multipart/mixed; boundary="===============6386211772098293224=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: Re: [PATCH] plugin: add plugin for Linktop/Teracom LW273 data card
Date: Thu, 03 Feb 2011 22:04:39 +0530
Message-ID: <AANLkTi=cz3mwErBKbsDhFYsmGnXrcF=nyKANdYOViGDo@mail.gmail.com>
In-Reply-To: <4d4ad72f.23968e0a.65af.3ec8@mx.google.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6386211772098293224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The LW273 and LW272 devices are being distributed by BSNL in India
with Teracom
brand name. Both the devices have similar specs except data speed and having
same
usb id (230d:0001).

Links:

http://www.bsnl.in/service/3G/3G_files/3g.htm
http://www.teracom.in/htmls/3G.html
http://www.linktop.com.cn/en/Products.asp?FID=3D1&LID=3D302
http://amit-mendapara.blogspot.com/2010/11/amazing-bsnl-3g.html

Regards
--
Amit Mendapara

On Thu, Feb 3, 2011 at 8:33 PM, Amit Mendapara <mendapara.amit@gmail.com>=
wrote:

> Signed-off-by: Amit Mendapara <mendapara.amit@gmail.com>
> ---
>  Makefile.am         |    3 +
>  plugins/linktop.c   |  357
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  plugins/ofono.rules |    3 +
>  plugins/udev.c      |   32 +++++
>  4 files changed, 395 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/linktop.c
>
> diff --git a/Makefile.am b/Makefile.am
> index 758fb10..2fb8962 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -314,6 +314,9 @@ builtin_sources +=3D plugins/nokia.c
>  builtin_modules +=3D nokiacdma
>  builtin_sources +=3D plugins/nokiacdma.c
>
> +builtin_modules +=3D linktop
> +builtin_sources +=3D plugins/linktop.c
> +
>  if BLUETOOTH
>  builtin_modules +=3D bluetooth
>  builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
> diff --git a/plugins/linktop.c b/plugins/linktop.c
> new file mode 100644
> index 0000000..7f552b5
> --- /dev/null
> +++ b/plugins/linktop.c
> @@ -0,0 +1,357 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
>  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +
> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gattty.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/modem.h>
> +#include <ofono/call-barring.h>
> +#include <ofono/call-forwarding.h>
> +#include <ofono/call-meter.h>
> +#include <ofono/call-settings.h>
> +#include <ofono/devinfo.h>
> +#include <ofono/message-waiting.h>
> +#include <ofono/netreg.h>
> +#include <ofono/sim.h>
> +#include <ofono/cbs.h>
> +#include <ofono/sms.h>
> +#include <ofono/ssn.h>
> +#include <ofono/ussd.h>
> +#include <ofono/call-volume.h>
> +#include <ofono/voicecall.h>
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
> +#include <ofono/phonebook.h>
> +#include <ofono/radio-settings.h>
> +#include <ofono/log.h>
> +
> +#include <drivers/atmodem/vendor.h>
> +#include <drivers/atmodem/atutil.h>
> +
> +static const char *none_prefix[] =3D { NULL };
> +
> +struct linktop_data {
> +       GAtChat *modem;
> +       GAtChat *control;
> +       struct ofono_gprs *gprs;
> +       struct ofono_gprs_context *gc;
> +};
> +
> +static int linktop_probe(struct ofono_modem *modem)
> +{
> +       struct linktop_data *data;
> +
> +       DBG("%p", modem);
> +
> +       data =3D g_try_new0(struct linktop_data, 1);
> +       if (data =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       ofono_modem_set_data(modem, data);
> +
> +       return 0;
> +}
> +
> +static void linktop_remove(struct ofono_modem *modem)
> +{
> +       struct linktop_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       ofono_modem_set_data(modem, NULL);
> +
> +       g_at_chat_unref(data->modem);
> +       g_at_chat_unref(data->control);
> +
> +       g_free(data);
> +}
> +
> +static void linktop_debug(const char *str, void *user_data)
> +{
> +        const char *prefix =3D user_data;
> +
> +        ofono_info("%s%s", prefix, str);
> +}
> +
> +static GAtChat *open_device(struct ofono_modem *modem,
> +                               const char *key, char *debug)
> +{
> +       const char *device;
> +       GAtSyntax *syntax;
> +       GIOChannel *channel;
> +       GAtChat *chat;
> +
> +       device =3D ofono_modem_get_string(modem, key);
> +       if (device =3D=3D NULL)
> +               return NULL;
> +
> +       DBG("%s %s", key, device);
> +
> +       channel =3D g_at_tty_open(device, NULL);
> +       if (channel =3D=3D NULL)
> +               return NULL;
> +
> +       syntax =3D g_at_syntax_new_gsm_permissive();
> +       chat =3D g_at_chat_new(channel, syntax);
> +       g_at_syntax_unref(syntax);
> +       g_io_channel_unref(channel);
> +
> +       if (chat =3D=3D NULL)
> +               return NULL;
> +
> +       if (getenv("OFONO_AT_DEBUG"))
> +               g_at_chat_set_debug(chat, linktop_debug, debug);
> +
> +       return chat;
> +}
> +
> +static void linktop_disconnect(gpointer user_data)
> +{
> +       struct ofono_modem *modem =3D user_data;
> +       struct linktop_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("");
> +
> +       if (data->gc)
> +               ofono_gprs_context_remove(data->gc);
> +
> +       g_at_chat_unref(data->modem);
> +       data->modem =3D NULL;
> +
> +       data->modem =3D open_device(modem, "Modem", "Modem: ");
> +       if (data->modem =3D=3D NULL)
> +               return;
> +
> +       g_at_chat_set_disconnect_function(data->modem,
> +                                               linktop_disconnect, modem=
);
> +
> +       ofono_info("Reopened GPRS context channel");
> +
> +       data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
> data->modem);
> +
> +       if (data->gprs && data->gc)
> +               ofono_gprs_add_context(data->gprs, data->gc);
> +}
> +
> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +       struct ofono_modem *modem =3D user_data;
> +
> +       DBG("");
> +
> +       ofono_modem_set_powered(modem, ok);
> +}
> +
> +static int linktop_enable(struct ofono_modem *modem)
> +{
> +       struct linktop_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       data->modem =3D open_device(modem, "Modem", "Modem: ");
> +       if (data->modem =3D=3D NULL)
> +               return -EINVAL;
> +
> +       g_at_chat_set_disconnect_function(data->modem,
> +                                               linktop_disconnect, modem=
);
> +
> +       data->control =3D open_device(modem, "Control", "Control: ");
> +       if (data->control =3D=3D NULL) {
> +               g_at_chat_unref(data->modem);
> +               data->modem =3D NULL;
> +               return -EIO;
> +       }
> +
> +       g_at_chat_send(data->control, "ATE0 +CMEE=3D1", none_prefix,
> +                                               NULL, NULL, NULL);
> +
> +       g_at_chat_send(data->modem, "AT", none_prefix,
> +                                               NULL, NULL, NULL);
> +
> +       g_at_chat_send(data->modem, "AT &F", none_prefix,
> +                                               NULL, NULL, NULL);
> +
> +       g_at_chat_send(data->control, "AT+CFUN=3D1", none_prefix,
> +                                       cfun_enable, modem, NULL);
> +
> +       return -EINPROGRESS;
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +       struct ofono_modem *modem =3D user_data;
> +       struct linktop_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("");
> +
> +       g_at_chat_unref(data->control);
> +       data->control =3D NULL;
> +
> +       if (ok)
> +               ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static int linktop_disable(struct ofono_modem *modem)
> +{
> +       struct linktop_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       if (data->modem) {
> +               g_at_chat_cancel_all(data->modem);
> +               g_at_chat_unregister_all(data->modem);
> +               g_at_chat_unref(data->modem);
> +               data->modem =3D NULL;
> +       }
> +
> +       if (data->control =3D=3D NULL)
> +               return 0;
> +
> +       g_at_chat_cancel_all(data->control);
> +       g_at_chat_unregister_all(data->control);
> +       g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
> +                                       cfun_disable, modem, NULL);
> +
> +       return -EINPROGRESS;
> +}
> +
> +static void set_online_cb(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +       struct cb_data *cbd =3D user_data;
> +       ofono_modem_online_cb_t cb =3D cbd->cb;
> +
> +       if (ok)
> +               CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +       else
> +               CALLBACK_WITH_FAILURE(cb, cbd->data);
> +}
> +
> +static void linktop_set_online(struct ofono_modem *modem, ofono_bool_t
> online,
> +                               ofono_modem_online_cb_t cb, void
> *user_data)
> +{
> +       struct linktop_data *data =3D ofono_modem_get_data(modem);
> +       GAtChat *chat =3D data->control;
> +       struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +       char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
> +
> +       DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +       if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd,
> g_free))
> +               return;
> +
> +       g_free(cbd);
> +
> +       CALLBACK_WITH_FAILURE(cb, cbd->data);
> +}
> +
> +static void linktop_pre_sim(struct ofono_modem *modem)
> +{
> +       struct linktop_data *data =3D ofono_modem_get_data(modem);
> +       struct ofono_sim *sim;
> +
> +       DBG("%p", modem);
> +
> +       ofono_devinfo_create(modem, 0, "atmodem", data->control);
> +       sim =3D ofono_sim_create(modem, 0, "atmodem", data->control);
> +       ofono_voicecall_create(modem, 0, "stemodem", data->control);
> +
> +       if (sim)
> +               ofono_sim_inserted_notify(sim, TRUE);
> +}
> +
> +static void linktop_post_sim(struct ofono_modem *modem)
> +{
> +       struct linktop_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       ofono_radio_settings_create(modem, 0, "stemodem", data->control);
> +       ofono_phonebook_create(modem, 0, "atmodem", data->control);
> +       ofono_sms_create(modem, 0, "atmodem", data->control);
> +}
> +
> +static void linktop_post_online(struct ofono_modem *modem)
> +{
> +       struct linktop_data *data =3D ofono_modem_get_data(modem);
> +       struct ofono_message_waiting *mw;
> +       struct ofono_gprs *gprs;
> +       struct ofono_gprs_context *gc;
> +
> +       DBG("%p", modem);
> +
> +       ofono_ussd_create(modem, 0, "atmodem", data->control);
> +       ofono_call_forwarding_create(modem, 0, "atmodem", data->control);
> +       ofono_call_settings_create(modem, 0, "atmodem", data->control);
> +       ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem",
> data->control);
> +       ofono_call_meter_create(modem, 0, "atmodem", data->control);
> +       ofono_call_barring_create(modem, 0, "atmodem", data->control);
> +       ofono_ssn_create(modem, 0, "atmodem", data->control);
> +       ofono_call_volume_create(modem, 0, "atmodem", data->control);
> +       ofono_cbs_create(modem, 0, "atmodem", data->control);
> +
> +       gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
> +                                       "atmodem", data->control);
> +       gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem=
);
> +
> +       if (gprs && gc)
> +               ofono_gprs_add_context(gprs, gc);
> +
> +       mw =3D ofono_message_waiting_create(modem);
> +
> +       if (mw)
> +               ofono_message_waiting_register(mw);
> +}
> +
> +static struct ofono_modem_driver linktop_driver =3D {
> +       .name           =3D "linktop",
> +       .probe          =3D linktop_probe,
> +       .remove         =3D linktop_remove,
> +       .enable         =3D linktop_enable,
> +       .disable        =3D linktop_disable,
> +       .set_online =3D linktop_set_online,
> +       .pre_sim        =3D linktop_pre_sim,
> +       .post_sim       =3D linktop_post_sim,
> +       .post_online    =3D linktop_post_online,
> +};
> +
> +static int linktop_init(void)
> +{
> +       return ofono_modem_driver_register(&linktop_driver);
> +}
> +
> +static void linktop_exit(void)
> +{
> +       ofono_modem_driver_unregister(&linktop_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(linktop, "Linktop Datacard modem driver", VERSION,
> +               OFONO_PLUGIN_PRIORITY_DEFAULT, linktop_init, linktop_exit)
> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 111f071..c7a77fe 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -451,4 +451,7 @@ ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"0=
623",
> ENV{OFONO_DRIVER}=3D"nokia"
>  ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"023e",
> ENV{OFONO_DRIVER}=3D"nokiacdma"
>  ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b6",
> ENV{OFONO_DRIVER}=3D"nokiacdma"
>
> ++# Teracom (Linktop/273) 3G Data Card
> ++ATTRS{idVendor}=3D=3D"230d", ATTRS{idProduct}=3D=3D"0001",
> ENV{OFONO_DRIVER}=3D"linktop"
> +
>  LABEL=3D"ofono_end"
> diff --git a/plugins/udev.c b/plugins/udev.c
> index ce1efe6..84478d7 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -552,6 +552,36 @@ static void add_nokiacdma(struct ofono_modem *modem,
>        ofono_modem_register(modem);
>  }
>
> +static void add_linktop(struct ofono_modem *modem,
> +                                       struct udev_device *udev_device)
> +{
> +       const char *devnode, *intfnum;
> +       struct udev_device *parent;
> +       int registered;
> +
> +       DBG("modem %p", modem);
> +
> +       registered =3D ofono_modem_get_integer(modem, "Registered");
> +       if (registered !=3D 0)
> +               return;
> +
> +       parent =3D udev_device_get_parent(udev_device);
> +       intfnum =3D udev_device_get_sysattr_value(parent,
> "bInterfaceNumber");
> +
> +       DBG("intfnum %s", intfnum);
> +
> +       if (g_strcmp0(intfnum, "01") =3D=3D 0) {
> +               devnode =3D udev_device_get_devnode(udev_device);
> +               ofono_modem_set_string(modem, "Modem", devnode);
> +       } else if (g_strcmp0(intfnum, "03") =3D=3D 0) {
> +               devnode =3D udev_device_get_devnode(udev_device);
> +               ofono_modem_set_string(modem, "Control", devnode);
> +
> +               ofono_modem_set_integer(modem, "Registered", 1);
> +               ofono_modem_register(modem);
> +       }
> +}
> +
>  static void add_modem(struct udev_device *udev_device)
>  {
>        struct ofono_modem *modem;
> @@ -646,6 +676,8 @@ done:
>                add_tc65(modem, udev_device);
>        else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
>                add_nokiacdma(modem, udev_device);
> +        else if (g_strcmp0(driver, "linktop") =3D=3D 0)
> +               add_linktop(modem, udev_device);
>  }
>
>  static gboolean devpath_remove(gpointer key, gpointer value, gpointer
> user_data)
> --
> 1.7.1
>
>

--===============6386211772098293224==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

VGhlIExXMjczIGFuZCBMVzI3MiBkZXZpY2VzIGFyZSBiZWluZyBkaXN0cmlidXRlZCBieSBCU05M
IGluIEluZGlhIHdpdGigVGVyYWNvbTxkaXY+YnJhbmQgbmFtZS4gQm90aCB0aGUgZGV2aWNlcyBo
YXZlIHNpbWlsYXIgc3BlY3MgZXhjZXB0IGRhdGEgc3BlZWQgYW5kIGhhdmluZyBzYW1lPC9kaXY+
PGRpdj51c2IgaWQgKDIzMGQ6MDAwMSkuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5MaW5rczo8
L2Rpdj4KPGRpdj48YnI+PC9kaXY+PGRpdj48YSBocmVmPSJodHRwOi8vd3d3LmJzbmwuaW4vc2Vy
dmljZS8zRy8zR19maWxlcy8zZy5odG0iPmh0dHA6Ly93d3cuYnNubC5pbi9zZXJ2aWNlLzNHLzNH
X2ZpbGVzLzNnLmh0bTwvYT48L2Rpdj48ZGl2PjxhIGhyZWY9Imh0dHA6Ly93d3cudGVyYWNvbS5p
bi9odG1scy8zRy5odG1sIj5odHRwOi8vd3d3LnRlcmFjb20uaW4vaHRtbHMvM0cuaHRtbDwvYT48
L2Rpdj4KPGRpdj48YSBocmVmPSJodHRwOi8vd3d3Lmxpbmt0b3AuY29tLmNuL2VuL1Byb2R1Y3Rz
LmFzcD9GSUQ9MSZhbXA7TElEPTMwMiI+aHR0cDovL3d3dy5saW5rdG9wLmNvbS5jbi9lbi9Qcm9k
dWN0cy5hc3A/RklEPTEmYW1wO0xJRD0zMDI8L2E+PC9kaXY+PGRpdj48YSBocmVmPSJodHRwOi8v
YW1pdC1tZW5kYXBhcmEuYmxvZ3Nwb3QuY29tLzIwMTAvMTEvYW1hemluZy1ic25sLTNnLmh0bWwi
Pmh0dHA6Ly9hbWl0LW1lbmRhcGFyYS5ibG9nc3BvdC5jb20vMjAxMC8xMS9hbWF6aW5nLWJzbmwt
M2cuaHRtbDwvYT48L2Rpdj4KPGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzPC9kaXY+PGRpdj4t
LTwvZGl2PjxkaXY+QW1pdCBNZW5kYXBhcmE8YnI+PGRpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPk9uIFRodSwgRmViIDMsIDIwMTEgYXQgODozMyBQTSwgQW1pdCBNZW5kYXBhcmEgPHNw
YW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWVuZGFwYXJhLmFtaXRAZ21haWwuY29t
Ij5tZW5kYXBhcmEuYW1pdEBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPgo8Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3Jk
ZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4OyI+U2lnbmVkLW9mZi1ieTog
QW1pdCBNZW5kYXBhcmEgJmx0OzxhIGhyZWY9Im1haWx0bzptZW5kYXBhcmEuYW1pdEBnbWFpbC5j
b20iPm1lbmRhcGFyYS5hbWl0QGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPgotLS08YnI+CqBNYWtlZmls
ZS5hbSCgIKAgoCCgIHwgoCCgMyArPGJyPgqgcGx1Z2lucy9saW5rdG9wLmMgoCB8IKAzNTcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyPgqgcGx1
Z2lucy9vZm9uby5ydWxlcyB8IKAgoDMgKzxicj4KoHBsdWdpbnMvdWRldi5jIKAgoCCgfCCgIDMy
ICsrKysrPGJyPgqgNCBmaWxlcyBjaGFuZ2VkLCAzOTUgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlv
bnMoLSk8YnI+CqBjcmVhdGUgbW9kZSAxMDA2NDQgcGx1Z2lucy9saW5rdG9wLmM8YnI+Cjxicj4K
ZGlmZiAtLWdpdCBhL01ha2VmaWxlLmFtIGIvTWFrZWZpbGUuYW08YnI+CmluZGV4IDc1OGZiMTAu
LjJmYjg5NjIgMTAwNjQ0PGJyPgotLS0gYS9NYWtlZmlsZS5hbTxicj4KKysrIGIvTWFrZWZpbGUu
YW08YnI+CkBAIC0zMTQsNiArMzE0LDkgQEAgYnVpbHRpbl9zb3VyY2VzICs9IHBsdWdpbnMvbm9r
aWEuYzxicj4KoGJ1aWx0aW5fbW9kdWxlcyArPSBub2tpYWNkbWE8YnI+CqBidWlsdGluX3NvdXJj
ZXMgKz0gcGx1Z2lucy9ub2tpYWNkbWEuYzxicj4KPGJyPgorYnVpbHRpbl9tb2R1bGVzICs9IGxp
bmt0b3A8YnI+CitidWlsdGluX3NvdXJjZXMgKz0gcGx1Z2lucy9saW5rdG9wLmM8YnI+Cis8YnI+
CqBpZiBCTFVFVE9PVEg8YnI+CqBidWlsdGluX21vZHVsZXMgKz0gYmx1ZXRvb3RoPGJyPgqgYnVp
bHRpbl9zb3VyY2VzICs9IHBsdWdpbnMvYmx1ZXRvb3RoLmMgcGx1Z2lucy9ibHVldG9vdGguaDxi
cj4KZGlmZiAtLWdpdCBhL3BsdWdpbnMvbGlua3RvcC5jIGIvcGx1Z2lucy9saW5rdG9wLmM8YnI+
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0PGJyPgppbmRleCAwMDAwMDAwLi43ZjU1MmI1PGJyPgotLS0g
L2Rldi9udWxsPGJyPgorKysgYi9wbHVnaW5zL2xpbmt0b3AuYzxicj4KQEAgLTAsMCArMSwzNTcg
QEA8YnI+CisvKjxicj4KKyAqPGJyPgorICogoG9Gb25vIC0gT3BlbiBTb3VyY2UgVGVsZXBob255
PGJyPgorICo8YnI+CisgKiCgQ29weXJpZ2h0IChDKSAyMDA4LTIwMTAgoEludGVsIENvcnBvcmF0
aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVkLjxicj4KKyAqPGJyPgorICogoFRoaXMgcHJvZ3JhbSBp
cyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5PGJy
PgorICogoGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgdmVyc2lvbiAyIGFzPGJyPgorICogoHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBG
b3VuZGF0aW9uLjxicj4KKyAqPGJyPgorICogoFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBp
biB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLDxicj4KKyAqIKBidXQgV0lUSE9VVCBB
TlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZjxicj4KKyAq
IKBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuIKBT
ZWUgdGhlPGJyPgorICogoEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFp
bHMuPGJyPgorICo8YnI+CisgKiCgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2U8YnI+CisgKiCgYWxvbmcgd2l0aCB0aGlzIHBy
b2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmU8YnI+CisgKiCgRm91bmRh
dGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIKAwMjEx
MC0xMzAxIKBVU0E8YnI+CisgKjxicj4KKyAqLzxicj4KKzxicj4KKyNpZmRlZiBIQVZFX0NPTkZJ
R19IPGJyPgorI2luY2x1ZGUgJmx0O2NvbmZpZy5oJmd0Ozxicj4KKyNlbmRpZjxicj4KKzxicj4K
KyNpbmNsdWRlICZsdDtzdGRpby5oJmd0Ozxicj4KKyNpbmNsdWRlICZsdDtlcnJuby5oJmd0Ozxi
cj4KKyNpbmNsdWRlICZsdDtzdGRsaWIuaCZndDs8YnI+Cis8YnI+CisjaW5jbHVkZSAmbHQ7Z2xp
Yi5oJmd0Ozxicj4KKyNpbmNsdWRlICZsdDtnYXRjaGF0LmgmZ3Q7PGJyPgorI2luY2x1ZGUgJmx0
O2dhdHR0eS5oJmd0Ozxicj4KKzxicj4KKyNkZWZpbmUgT0ZPTk9fQVBJX1NVQkpFQ1RfVE9fQ0hB
TkdFPGJyPgorI2luY2x1ZGUgJmx0O29mb25vL3BsdWdpbi5oJmd0Ozxicj4KKyNpbmNsdWRlICZs
dDtvZm9uby9tb2RlbS5oJmd0Ozxicj4KKyNpbmNsdWRlICZsdDtvZm9uby9jYWxsLWJhcnJpbmcu
aCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vY2FsbC1mb3J3YXJkaW5nLmgmZ3Q7PGJyPgor
I2luY2x1ZGUgJmx0O29mb25vL2NhbGwtbWV0ZXIuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zv
bm8vY2FsbC1zZXR0aW5ncy5oJmd0Ozxicj4KKyNpbmNsdWRlICZsdDtvZm9uby9kZXZpbmZvLmgm
Z3Q7PGJyPgorI2luY2x1ZGUgJmx0O29mb25vL21lc3NhZ2Utd2FpdGluZy5oJmd0Ozxicj4KKyNp
bmNsdWRlICZsdDtvZm9uby9uZXRyZWcuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vc2lt
LmgmZ3Q7PGJyPgorI2luY2x1ZGUgJmx0O29mb25vL2Nicy5oJmd0Ozxicj4KKyNpbmNsdWRlICZs
dDtvZm9uby9zbXMuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vc3NuLmgmZ3Q7PGJyPgor
I2luY2x1ZGUgJmx0O29mb25vL3Vzc2QuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vY2Fs
bC12b2x1bWUuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vdm9pY2VjYWxsLmgmZ3Q7PGJy
PgorI2luY2x1ZGUgJmx0O29mb25vL2dwcnMuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8v
Z3Bycy1jb250ZXh0LmgmZ3Q7PGJyPgorI2luY2x1ZGUgJmx0O29mb25vL3Bob25lYm9vay5oJmd0
Ozxicj4KKyNpbmNsdWRlICZsdDtvZm9uby9yYWRpby1zZXR0aW5ncy5oJmd0Ozxicj4KKyNpbmNs
dWRlICZsdDtvZm9uby9sb2cuaCZndDs8YnI+Cis8YnI+CisjaW5jbHVkZSAmbHQ7ZHJpdmVycy9h
dG1vZGVtL3ZlbmRvci5oJmd0Ozxicj4KKyNpbmNsdWRlICZsdDtkcml2ZXJzL2F0bW9kZW0vYXR1
dGlsLmgmZ3Q7PGJyPgorPGJyPgorc3RhdGljIGNvbnN0IGNoYXIgKm5vbmVfcHJlZml4W10gPSB7
IE5VTEwgfTs8YnI+Cis8YnI+CitzdHJ1Y3QgbGlua3RvcF9kYXRhIHs8YnI+CisgoCCgIKAgR0F0
Q2hhdCAqbW9kZW07PGJyPgorIKAgoCCgIEdBdENoYXQgKmNvbnRyb2w7PGJyPgorIKAgoCCgIHN0
cnVjdCBvZm9ub19ncHJzICpncHJzOzxicj4KKyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250
ZXh0ICpnYzs8YnI+Cit9Ozxicj4KKzxicj4KK3N0YXRpYyBpbnQgbGlua3RvcF9wcm9iZShzdHJ1
Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxicj4KK3s8YnI+CisgoCCgIKAgc3RydWN0IGxpbmt0b3Bf
ZGF0YSAqZGF0YTs8YnI+Cis8YnI+CisgoCCgIKAgREJHKCZxdW90OyVwJnF1b3Q7LCBtb2RlbSk7
PGJyPgorPGJyPgorIKAgoCCgIGRhdGEgPSBnX3RyeV9uZXcwKHN0cnVjdCBsaW5rdG9wX2RhdGEs
IDEpOzxicj4KKyCgIKAgoCBpZiAoZGF0YSA9PSBOVUxMKTxicj4KKyCgIKAgoCCgIKAgoCCgIHJl
dHVybiAtRU5PTUVNOzxicj4KKzxicj4KKyCgIKAgoCBvZm9ub19tb2RlbV9zZXRfZGF0YShtb2Rl
bSwgZGF0YSk7PGJyPgorPGJyPgorIKAgoCCgIHJldHVybiAwOzxicj4KK308YnI+Cis8YnI+Citz
dGF0aWMgdm9pZCBsaW5rdG9wX3JlbW92ZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxicj4K
K3s8YnI+CisgoCCgIKAgc3RydWN0IGxpbmt0b3BfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dl
dF9kYXRhKG1vZGVtKTs8YnI+Cis8YnI+CisgoCCgIKAgREJHKCZxdW90OyVwJnF1b3Q7LCBtb2Rl
bSk7PGJyPgorPGJyPgorIKAgoCCgIG9mb25vX21vZGVtX3NldF9kYXRhKG1vZGVtLCBOVUxMKTs8
YnI+Cis8YnI+CisgoCCgIKAgZ19hdF9jaGF0X3VucmVmKGRhdGEtJmd0O21vZGVtKTs8YnI+Cisg
oCCgIKAgZ19hdF9jaGF0X3VucmVmKGRhdGEtJmd0O2NvbnRyb2wpOzxicj4KKzxicj4KKyCgIKAg
oCBnX2ZyZWUoZGF0YSk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lkIGxpbmt0b3BfZGVi
dWcoY29uc3QgY2hhciAqc3RyLCB2b2lkICp1c2VyX2RhdGEpPGJyPgorezxicj4KKyCgIKAgoCCg
Y29uc3QgY2hhciAqcHJlZml4ID0gdXNlcl9kYXRhOzxicj4KKzxicj4KKyCgIKAgoCCgb2Zvbm9f
aW5mbygmcXVvdDslcyVzJnF1b3Q7LCBwcmVmaXgsIHN0cik7PGJyPgorfTxicj4KKzxicj4KK3N0
YXRpYyBHQXRDaGF0ICpvcGVuX2RldmljZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtLDxicj4K
KyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBjb25zdCBjaGFyICprZXksIGNoYXIgKmRl
YnVnKTxicj4KK3s8YnI+CisgoCCgIKAgY29uc3QgY2hhciAqZGV2aWNlOzxicj4KKyCgIKAgoCBH
QXRTeW50YXggKnN5bnRheDs8YnI+CisgoCCgIKAgR0lPQ2hhbm5lbCAqY2hhbm5lbDs8YnI+Cisg
oCCgIKAgR0F0Q2hhdCAqY2hhdDs8YnI+Cis8YnI+CisgoCCgIKAgZGV2aWNlID0gb2Zvbm9fbW9k
ZW1fZ2V0X3N0cmluZyhtb2RlbSwga2V5KTs8YnI+CisgoCCgIKAgaWYgKGRldmljZSA9PSBOVUxM
KTxicj4KKyCgIKAgoCCgIKAgoCCgIHJldHVybiBOVUxMOzxicj4KKzxicj4KKyCgIKAgoCBEQkco
JnF1b3Q7JXMgJXMmcXVvdDssIGtleSwgZGV2aWNlKTs8YnI+Cis8YnI+CisgoCCgIKAgY2hhbm5l
bCA9IGdfYXRfdHR5X29wZW4oZGV2aWNlLCBOVUxMKTs8YnI+CisgoCCgIKAgaWYgKGNoYW5uZWwg
PT0gTlVMTCk8YnI+CisgoCCgIKAgoCCgIKAgoCByZXR1cm4gTlVMTDs8YnI+Cis8YnI+CisgoCCg
IKAgc3ludGF4ID0gZ19hdF9zeW50YXhfbmV3X2dzbV9wZXJtaXNzaXZlKCk7PGJyPgorIKAgoCCg
IGNoYXQgPSBnX2F0X2NoYXRfbmV3KGNoYW5uZWwsIHN5bnRheCk7PGJyPgorIKAgoCCgIGdfYXRf
c3ludGF4X3VucmVmKHN5bnRheCk7PGJyPgorIKAgoCCgIGdfaW9fY2hhbm5lbF91bnJlZihjaGFu
bmVsKTs8YnI+Cis8YnI+CisgoCCgIKAgaWYgKGNoYXQgPT0gTlVMTCk8YnI+CisgoCCgIKAgoCCg
IKAgoCByZXR1cm4gTlVMTDs8YnI+Cis8YnI+CisgoCCgIKAgaWYgKGdldGVudigmcXVvdDtPRk9O
T19BVF9ERUJVRyZxdW90OykpPGJyPgorIKAgoCCgIKAgoCCgIKAgZ19hdF9jaGF0X3NldF9kZWJ1
ZyhjaGF0LCBsaW5rdG9wX2RlYnVnLCBkZWJ1Zyk7PGJyPgorPGJyPgorIKAgoCCgIHJldHVybiBj
aGF0Ozxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCBsaW5rdG9wX2Rpc2Nvbm5lY3QoZ3Bv
aW50ZXIgdXNlcl9kYXRhKTxicj4KK3s8YnI+CisgoCCgIKAgc3RydWN0IG9mb25vX21vZGVtICpt
b2RlbSA9IHVzZXJfZGF0YTs8YnI+CisgoCCgIKAgc3RydWN0IGxpbmt0b3BfZGF0YSAqZGF0YSA9
IG9mb25vX21vZGVtX2dldF9kYXRhKG1vZGVtKTs8YnI+Cis8YnI+CisgoCCgIKAgREJHKCZxdW90
OyZxdW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIGlmIChkYXRhLSZndDtnYyk8YnI+CisgoCCgIKAg
oCCgIKAgoCBvZm9ub19ncHJzX2NvbnRleHRfcmVtb3ZlKGRhdGEtJmd0O2djKTs8YnI+Cis8YnI+
CisgoCCgIKAgZ19hdF9jaGF0X3VucmVmKGRhdGEtJmd0O21vZGVtKTs8YnI+CisgoCCgIKAgZGF0
YS0mZ3Q7bW9kZW0gPSBOVUxMOzxicj4KKzxicj4KKyCgIKAgoCBkYXRhLSZndDttb2RlbSA9IG9w
ZW5fZGV2aWNlKG1vZGVtLCAmcXVvdDtNb2RlbSZxdW90OywgJnF1b3Q7TW9kZW06ICZxdW90Oyk7
PGJyPgorIKAgoCCgIGlmIChkYXRhLSZndDttb2RlbSA9PSBOVUxMKTxicj4KKyCgIKAgoCCgIKAg
oCCgIHJldHVybjs8YnI+Cis8YnI+CisgoCCgIKAgZ19hdF9jaGF0X3NldF9kaXNjb25uZWN0X2Z1
bmN0aW9uKGRhdGEtJmd0O21vZGVtLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgbGlua3RvcF9kaXNjb25uZWN0LCBtb2RlbSk7PGJyPgorPGJyPgor
IKAgoCCgIG9mb25vX2luZm8oJnF1b3Q7UmVvcGVuZWQgR1BSUyBjb250ZXh0IGNoYW5uZWwmcXVv
dDspOzxicj4KKzxicj4KKyCgIKAgoCBkYXRhLSZndDtnYyA9IG9mb25vX2dwcnNfY29udGV4dF9j
cmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O21vZGVtKTs8YnI+
Cis8YnI+CisgoCCgIKAgaWYgKGRhdGEtJmd0O2dwcnMgJmFtcDsmYW1wOyBkYXRhLSZndDtnYyk8
YnI+CisgoCCgIKAgoCCgIKAgoCBvZm9ub19ncHJzX2FkZF9jb250ZXh0KGRhdGEtJmd0O2dwcnMs
IGRhdGEtJmd0O2djKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgY2Z1bl9lbmFibGUo
Z2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEpPGJyPgor
ezxicj4KKyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gdXNlcl9kYXRhOzxicj4K
Kzxicj4KKyCgIKAgoCBEQkcoJnF1b3Q7JnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgb2Zvbm9f
bW9kZW1fc2V0X3Bvd2VyZWQobW9kZW0sIG9rKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIGlu
dCBsaW5rdG9wX2VuYWJsZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxicj4KK3s8YnI+Cisg
oCCgIKAgc3RydWN0IGxpbmt0b3BfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1v
ZGVtKTs8YnI+Cis8YnI+CisgoCCgIKAgREJHKCZxdW90OyVwJnF1b3Q7LCBtb2RlbSk7PGJyPgor
PGJyPgorIKAgoCCgIGRhdGEtJmd0O21vZGVtID0gb3Blbl9kZXZpY2UobW9kZW0sICZxdW90O01v
ZGVtJnF1b3Q7LCAmcXVvdDtNb2RlbTogJnF1b3Q7KTs8YnI+CisgoCCgIKAgaWYgKGRhdGEtJmd0
O21vZGVtID09IE5VTEwpPGJyPgorIKAgoCCgIKAgoCCgIKAgcmV0dXJuIC1FSU5WQUw7PGJyPgor
PGJyPgorIKAgoCCgIGdfYXRfY2hhdF9zZXRfZGlzY29ubmVjdF9mdW5jdGlvbihkYXRhLSZndDtt
b2RlbSw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IGxpbmt0b3BfZGlzY29ubmVjdCwgbW9kZW0pOzxicj4KKzxicj4KKyCgIKAgoCBkYXRhLSZndDtj
b250cm9sID0gb3Blbl9kZXZpY2UobW9kZW0sICZxdW90O0NvbnRyb2wmcXVvdDssICZxdW90O0Nv
bnRyb2w6ICZxdW90Oyk7PGJyPgorIKAgoCCgIGlmIChkYXRhLSZndDtjb250cm9sID09IE5VTEwp
IHs8YnI+CisgoCCgIKAgoCCgIKAgoCBnX2F0X2NoYXRfdW5yZWYoZGF0YS0mZ3Q7bW9kZW0pOzxi
cj4KKyCgIKAgoCCgIKAgoCCgIGRhdGEtJmd0O21vZGVtID0gTlVMTDs8YnI+CisgoCCgIKAgoCCg
IKAgoCByZXR1cm4gLUVJTzs8YnI+CisgoCCgIKAgfTxicj4KKzxicj4KKyCgIKAgoCBnX2F0X2No
YXRfc2VuZChkYXRhLSZndDtjb250cm9sLCAmcXVvdDtBVEUwICtDTUVFPTEmcXVvdDssIG5vbmVf
cHJlZml4LDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgTlVMTCwgTlVMTCwgTlVMTCk7PGJyPgorPGJyPgorIKAgoCCgIGdfYXRfY2hhdF9zZW5kKGRh
dGEtJmd0O21vZGVtLCAmcXVvdDtBVCZxdW90Oywgbm9uZV9wcmVmaXgsPGJyPgorIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBOVUxMLCBOVUxMLCBOVUxMKTs8
YnI+Cis8YnI+CisgoCCgIKAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7bW9kZW0sICZxdW90O0FU
ICZhbXA7RiZxdW90Oywgbm9uZV9wcmVmaXgsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBOVUxMLCBOVUxMLCBOVUxMKTs8YnI+Cis8YnI+CisgoCCg
IKAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y29udHJvbCwgJnF1b3Q7QVQrQ0ZVTj0xJnF1b3Q7
LCBub25lX3ByZWZpeCw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCBjZnVuX2VuYWJsZSwgbW9kZW0sIE5VTEwpOzxicj4KKzxicj4KKyCgIKAgoCByZXR1cm4gLUVJ
TlBST0dSRVNTOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCBjZnVuX2Rpc2FibGUoZ2Jv
b2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEpPGJyPgorezxi
cj4KKyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gdXNlcl9kYXRhOzxicj4KKyCg
IKAgoCBzdHJ1Y3QgbGlua3RvcF9kYXRhICpkYXRhID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEobW9k
ZW0pOzxicj4KKzxicj4KKyCgIKAgoCBEQkcoJnF1b3Q7JnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCg
IKAgZ19hdF9jaGF0X3VucmVmKGRhdGEtJmd0O2NvbnRyb2wpOzxicj4KKyCgIKAgoCBkYXRhLSZn
dDtjb250cm9sID0gTlVMTDs8YnI+Cis8YnI+CisgoCCgIKAgaWYgKG9rKTxicj4KKyCgIKAgoCCg
IKAgoCCgIG9mb25vX21vZGVtX3NldF9wb3dlcmVkKG1vZGVtLCBGQUxTRSk7PGJyPgorfTxicj4K
Kzxicj4KK3N0YXRpYyBpbnQgbGlua3RvcF9kaXNhYmxlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9k
ZW0pPGJyPgorezxicj4KKyCgIKAgoCBzdHJ1Y3QgbGlua3RvcF9kYXRhICpkYXRhID0gb2Zvbm9f
bW9kZW1fZ2V0X2RhdGEobW9kZW0pOzxicj4KKzxicj4KKyCgIKAgoCBEQkcoJnF1b3Q7JXAmcXVv
dDssIG1vZGVtKTs8YnI+Cis8YnI+CisgoCCgIKAgaWYgKGRhdGEtJmd0O21vZGVtKSB7PGJyPgor
IKAgoCCgIKAgoCCgIKAgZ19hdF9jaGF0X2NhbmNlbF9hbGwoZGF0YS0mZ3Q7bW9kZW0pOzxicj4K
KyCgIKAgoCCgIKAgoCCgIGdfYXRfY2hhdF91bnJlZ2lzdGVyX2FsbChkYXRhLSZndDttb2RlbSk7
PGJyPgorIKAgoCCgIKAgoCCgIKAgZ19hdF9jaGF0X3VucmVmKGRhdGEtJmd0O21vZGVtKTs8YnI+
CisgoCCgIKAgoCCgIKAgoCBkYXRhLSZndDttb2RlbSA9IE5VTEw7PGJyPgorIKAgoCCgIH08YnI+
Cis8YnI+CisgoCCgIKAgaWYgKGRhdGEtJmd0O2NvbnRyb2wgPT0gTlVMTCk8YnI+CisgoCCgIKAg
oCCgIKAgoCByZXR1cm4gMDs8YnI+Cis8YnI+CisgoCCgIKAgZ19hdF9jaGF0X2NhbmNlbF9hbGwo
ZGF0YS0mZ3Q7Y29udHJvbCk7PGJyPgorIKAgoCCgIGdfYXRfY2hhdF91bnJlZ2lzdGVyX2FsbChk
YXRhLSZndDtjb250cm9sKTs8YnI+CisgoCCgIKAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y29u
dHJvbCwgJnF1b3Q7QVQrQ0ZVTj00JnF1b3Q7LCBub25lX3ByZWZpeCw8YnI+CisgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBjZnVuX2Rpc2FibGUsIG1vZGVtLCBOVUxMKTs8
YnI+Cis8YnI+CisgoCCgIKAgcmV0dXJuIC1FSU5QUk9HUkVTUzs8YnI+Cit9PGJyPgorPGJyPgor
c3RhdGljIHZvaWQgc2V0X29ubGluZV9jYihnYm9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQs
IGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+Cit7PGJyPgorIKAgoCCgIHN0cnVjdCBjYl9kYXRhICpj
YmQgPSB1c2VyX2RhdGE7PGJyPgorIKAgoCCgIG9mb25vX21vZGVtX29ubGluZV9jYl90IGNiID0g
Y2JkLSZndDtjYjs8YnI+Cis8YnI+CisgoCCgIKAgaWYgKG9rKTxicj4KKyCgIKAgoCCgIKAgoCCg
IENBTExCQUNLX1dJVEhfU1VDQ0VTUyhjYiwgY2JkLSZndDtkYXRhKTs8YnI+CisgoCCgIKAgZWxz
ZTxicj4KKyCgIKAgoCCgIKAgoCCgIENBTExCQUNLX1dJVEhfRkFJTFVSRShjYiwgY2JkLSZndDtk
YXRhKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgbGlua3RvcF9zZXRfb25saW5lKHN0
cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sIG9mb25vX2Jvb2xfdCBvbmxpbmUsPGJyPgorIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIG9mb25vX21vZGVtX29ubGluZV9jYl90IGNiLCB2b2lk
ICp1c2VyX2RhdGEpPGJyPgorezxicj4KKyCgIKAgoCBzdHJ1Y3QgbGlua3RvcF9kYXRhICpkYXRh
ID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEobW9kZW0pOzxicj4KKyCgIKAgoCBHQXRDaGF0ICpjaGF0
ID0gZGF0YS0mZ3Q7Y29udHJvbDs8YnI+CisgoCCgIKAgc3RydWN0IGNiX2RhdGEgKmNiZCA9IGNi
X2RhdGFfbmV3KGNiLCB1c2VyX2RhdGEpOzxicj4KKyCgIKAgoCBjaGFyIGNvbnN0ICpjb21tYW5k
ID0gb25saW5lID8gJnF1b3Q7QVQrQ0ZVTj0xJnF1b3Q7IDogJnF1b3Q7QVQrQ0ZVTj00JnF1b3Q7
Ozxicj4KKzxicj4KKyCgIKAgoCBEQkcoJnF1b3Q7bW9kZW0gJXAgJXMmcXVvdDssIG1vZGVtLCBv
bmxpbmUgPyAmcXVvdDtvbmxpbmUmcXVvdDsgOiAmcXVvdDtvZmZsaW5lJnF1b3Q7KTs8YnI+Cis8
YnI+CisgoCCgIKAgaWYgKGdfYXRfY2hhdF9zZW5kKGNoYXQsIGNvbW1hbmQsIE5VTEwsIHNldF9v
bmxpbmVfY2IsIGNiZCwgZ19mcmVlKSk8YnI+CisgoCCgIKAgoCCgIKAgoCByZXR1cm47PGJyPgor
PGJyPgorIKAgoCCgIGdfZnJlZShjYmQpOzxicj4KKzxicj4KKyCgIKAgoCBDQUxMQkFDS19XSVRI
X0ZBSUxVUkUoY2IsIGNiZC0mZ3Q7ZGF0YSk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lk
IGxpbmt0b3BfcHJlX3NpbShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxicj4KK3s8YnI+Cisg
oCCgIKAgc3RydWN0IGxpbmt0b3BfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1v
ZGVtKTs8YnI+CisgoCCgIKAgc3RydWN0IG9mb25vX3NpbSAqc2ltOzxicj4KKzxicj4KKyCgIKAg
oCBEQkcoJnF1b3Q7JXAmcXVvdDssIG1vZGVtKTs8YnI+Cis8YnI+CisgoCCgIKAgb2Zvbm9fZGV2
aW5mb19jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O2NvbnRy
b2wpOzxicj4KKyCgIKAgoCBzaW0gPSBvZm9ub19zaW1fY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDth
dG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjb250cm9sKTs8YnI+CisgoCCgIKAgb2Zvbm9fdm9pY2Vj
YWxsX2NyZWF0ZShtb2RlbSwgMCwgJnF1b3Q7c3RlbW9kZW0mcXVvdDssIGRhdGEtJmd0O2NvbnRy
b2wpOzxicj4KKzxicj4KKyCgIKAgoCBpZiAoc2ltKTxicj4KKyCgIKAgoCCgIKAgoCCgIG9mb25v
X3NpbV9pbnNlcnRlZF9ub3RpZnkoc2ltLCBUUlVFKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGlj
IHZvaWQgbGlua3RvcF9wb3N0X3NpbShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxicj4KK3s8
YnI+CisgoCCgIKAgc3RydWN0IGxpbmt0b3BfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9k
YXRhKG1vZGVtKTs8YnI+Cis8YnI+CisgoCCgIKAgREJHKCZxdW90OyVwJnF1b3Q7LCBtb2RlbSk7
PGJyPgorPGJyPgorIKAgoCCgIG9mb25vX3JhZGlvX3NldHRpbmdzX2NyZWF0ZShtb2RlbSwgMCwg
JnF1b3Q7c3RlbW9kZW0mcXVvdDssIGRhdGEtJmd0O2NvbnRyb2wpOzxicj4KKyCgIKAgoCBvZm9u
b19waG9uZWJvb2tfY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZn
dDtjb250cm9sKTs8YnI+CisgoCCgIKAgb2Zvbm9fc21zX2NyZWF0ZShtb2RlbSwgMCwgJnF1b3Q7
YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7Y29udHJvbCk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRp
YyB2b2lkIGxpbmt0b3BfcG9zdF9vbmxpbmUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+
Cit7PGJyPgorIKAgoCCgIHN0cnVjdCBsaW5rdG9wX2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9n
ZXRfZGF0YShtb2RlbSk7PGJyPgorIKAgoCCgIHN0cnVjdCBvZm9ub19tZXNzYWdlX3dhaXRpbmcg
Km13Ozxicj4KKyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Byczs8YnI+CisgoCCgIKAgc3Ry
dWN0IG9mb25vX2dwcnNfY29udGV4dCAqZ2M7PGJyPgorPGJyPgorIKAgoCCgIERCRygmcXVvdDsl
cCZxdW90OywgbW9kZW0pOzxicj4KKzxicj4KKyCgIKAgoCBvZm9ub191c3NkX2NyZWF0ZShtb2Rl
bSwgMCwgJnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7Y29udHJvbCk7PGJyPgorIKAgoCCg
IG9mb25vX2NhbGxfZm9yd2FyZGluZ19jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVv
dDssIGRhdGEtJmd0O2NvbnRyb2wpOzxicj4KKyCgIKAgoCBvZm9ub19jYWxsX3NldHRpbmdzX2Ny
ZWF0ZShtb2RlbSwgMCwgJnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7Y29udHJvbCk7PGJy
PgorIKAgoCCgIG9mb25vX25ldHJlZ19jcmVhdGUobW9kZW0sIE9GT05PX1ZFTkRPUl9NQk0sICZx
dW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O2NvbnRyb2wpOzxicj4KKyCgIKAgoCBvZm9ub19j
YWxsX21ldGVyX2NyZWF0ZShtb2RlbSwgMCwgJnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7
Y29udHJvbCk7PGJyPgorIKAgoCCgIG9mb25vX2NhbGxfYmFycmluZ19jcmVhdGUobW9kZW0sIDAs
ICZxdW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O2NvbnRyb2wpOzxicj4KKyCgIKAgoCBvZm9u
b19zc25fY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjb250
cm9sKTs8YnI+CisgoCCgIKAgb2Zvbm9fY2FsbF92b2x1bWVfY3JlYXRlKG1vZGVtLCAwLCAmcXVv
dDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjb250cm9sKTs8YnI+CisgoCCgIKAgb2Zvbm9fY2Jz
X2NyZWF0ZShtb2RlbSwgMCwgJnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7Y29udHJvbCk7
PGJyPgorPGJyPgorIKAgoCCgIGdwcnMgPSBvZm9ub19ncHJzX2NyZWF0ZShtb2RlbSwgT0ZPTk9f
VkVORE9SX01CTSw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAm
cXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjb250cm9sKTs8YnI+CisgoCCgIKAgZ2MgPSBv
Zm9ub19ncHJzX2NvbnRleHRfY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBk
YXRhLSZndDttb2RlbSk7PGJyPgorPGJyPgorIKAgoCCgIGlmIChncHJzICZhbXA7JmFtcDsgZ2Mp
PGJyPgorIKAgoCCgIKAgoCCgIKAgb2Zvbm9fZ3Byc19hZGRfY29udGV4dChncHJzLCBnYyk7PGJy
PgorPGJyPgorIKAgoCCgIG13ID0gb2Zvbm9fbWVzc2FnZV93YWl0aW5nX2NyZWF0ZShtb2RlbSk7
PGJyPgorPGJyPgorIKAgoCCgIGlmIChtdyk8YnI+CisgoCCgIKAgoCCgIKAgoCBvZm9ub19tZXNz
YWdlX3dhaXRpbmdfcmVnaXN0ZXIobXcpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgc3RydWN0
IG9mb25vX21vZGVtX2RyaXZlciBsaW5rdG9wX2RyaXZlciA9IHs8YnI+CisgoCCgIKAgLm5hbWUg
oCCgIKAgoCCgID0gJnF1b3Q7bGlua3RvcCZxdW90Oyw8YnI+CisgoCCgIKAgLnByb2JlIKAgoCCg
IKAgoD0gbGlua3RvcF9wcm9iZSw8YnI+CisgoCCgIKAgLnJlbW92ZSCgIKAgoCCgID0gbGlua3Rv
cF9yZW1vdmUsPGJyPgorIKAgoCCgIC5lbmFibGUgoCCgIKAgoCA9IGxpbmt0b3BfZW5hYmxlLDxi
cj4KKyCgIKAgoCAuZGlzYWJsZSCgIKAgoCCgPSBsaW5rdG9wX2Rpc2FibGUsPGJyPgorIKAgoCCg
IC5zZXRfb25saW5lID0gbGlua3RvcF9zZXRfb25saW5lLDxicj4KKyCgIKAgoCAucHJlX3NpbSCg
IKAgoCCgPSBsaW5rdG9wX3ByZV9zaW0sPGJyPgorIKAgoCCgIC5wb3N0X3NpbSCgIKAgoCA9IGxp
bmt0b3BfcG9zdF9zaW0sPGJyPgorIKAgoCCgIC5wb3N0X29ubGluZSCgIKA9IGxpbmt0b3BfcG9z
dF9vbmxpbmUsPGJyPgorfTs8YnI+Cis8YnI+CitzdGF0aWMgaW50IGxpbmt0b3BfaW5pdCh2b2lk
KTxicj4KK3s8YnI+CisgoCCgIKAgcmV0dXJuIG9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rlcigm
YW1wO2xpbmt0b3BfZHJpdmVyKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgbGlua3Rv
cF9leGl0KHZvaWQpPGJyPgorezxicj4KKyCgIKAgoCBvZm9ub19tb2RlbV9kcml2ZXJfdW5yZWdp
c3RlcigmYW1wO2xpbmt0b3BfZHJpdmVyKTs8YnI+Cit9PGJyPgorPGJyPgorT0ZPTk9fUExVR0lO
X0RFRklORShsaW5rdG9wLCAmcXVvdDtMaW5rdG9wIERhdGFjYXJkIG1vZGVtIGRyaXZlciZxdW90
OywgVkVSU0lPTiw8YnI+CisgoCCgIKAgoCCgIKAgoCBPRk9OT19QTFVHSU5fUFJJT1JJVFlfREVG
QVVMVCwgbGlua3RvcF9pbml0LCBsaW5rdG9wX2V4aXQpPGJyPgpkaWZmIC0tZ2l0IGEvcGx1Z2lu
cy9vZm9uby5ydWxlcyBiL3BsdWdpbnMvb2Zvbm8ucnVsZXM8YnI+CmluZGV4IDExMWYwNzEuLmM3
YTc3ZmUgMTAwNjQ0PGJyPgotLS0gYS9wbHVnaW5zL29mb25vLnJ1bGVzPGJyPgorKysgYi9wbHVn
aW5zL29mb25vLnJ1bGVzPGJyPgpAQCAtNDUxLDQgKzQ1MSw3IEBAIEFUVFJTe2lkVmVuZG9yfT09
JnF1b3Q7MDQyMSZxdW90OywgQVRUUlN7aWRQcm9kdWN0fT09JnF1b3Q7MDYyMyZxdW90OywgRU5W
e09GT05PX0RSSVZFUn09JnF1b3Q7bm9raWEmcXVvdDs8YnI+CqBBVFRSU3tpZFZlbmRvcn09PSZx
dW90OzA0MjEmcXVvdDssIEFUVFJTe2lkUHJvZHVjdH09PSZxdW90OzAyM2UmcXVvdDssIEVOVntP
Rk9OT19EUklWRVJ9PSZxdW90O25va2lhY2RtYSZxdW90Ozxicj4KoEFUVFJTe2lkVmVuZG9yfT09
JnF1b3Q7MDQyMSZxdW90OywgQVRUUlN7aWRQcm9kdWN0fT09JnF1b3Q7MDBiNiZxdW90OywgRU5W
e09GT05PX0RSSVZFUn09JnF1b3Q7bm9raWFjZG1hJnF1b3Q7PGJyPgo8YnI+CisrIyBUZXJhY29t
IChMaW5rdG9wLzI3MykgM0cgRGF0YSBDYXJkPGJyPgorK0FUVFJTe2lkVmVuZG9yfT09JnF1b3Q7
MjMwZCZxdW90OywgQVRUUlN7aWRQcm9kdWN0fT09JnF1b3Q7MDAwMSZxdW90OywgRU5We09GT05P
X0RSSVZFUn09JnF1b3Q7bGlua3RvcCZxdW90Ozxicj4KKzxicj4KoExBQkVMPSZxdW90O29mb25v
X2VuZCZxdW90Ozxicj4KZGlmZiAtLWdpdCBhL3BsdWdpbnMvdWRldi5jIGIvcGx1Z2lucy91ZGV2
LmM8YnI+CmluZGV4IGNlMWVmZTYuLjg0NDc4ZDcgMTAwNjQ0PGJyPgotLS0gYS9wbHVnaW5zL3Vk
ZXYuYzxicj4KKysrIGIvcGx1Z2lucy91ZGV2LmM8YnI+CkBAIC01NTIsNiArNTUyLDM2IEBAIHN0
YXRpYyB2b2lkIGFkZF9ub2tpYWNkbWEoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSw8YnI+CiCg
IKAgoCCgb2Zvbm9fbW9kZW1fcmVnaXN0ZXIobW9kZW0pOzxicj4KoH08YnI+Cjxicj4KK3N0YXRp
YyB2b2lkIGFkZF9saW5rdG9wKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sPGJyPgorIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgc3RydWN0IHVkZXZfZGV2aWNlICp1ZGV2
X2RldmljZSk8YnI+Cit7PGJyPgorIKAgoCCgIGNvbnN0IGNoYXIgKmRldm5vZGUsICppbnRmbnVt
Ozxicj4KKyCgIKAgoCBzdHJ1Y3QgdWRldl9kZXZpY2UgKnBhcmVudDs8YnI+CisgoCCgIKAgaW50
IHJlZ2lzdGVyZWQ7PGJyPgorPGJyPgorIKAgoCCgIERCRygmcXVvdDttb2RlbSAlcCZxdW90Oywg
bW9kZW0pOzxicj4KKzxicj4KKyCgIKAgoCByZWdpc3RlcmVkID0gb2Zvbm9fbW9kZW1fZ2V0X2lu
dGVnZXIobW9kZW0sICZxdW90O1JlZ2lzdGVyZWQmcXVvdDspOzxicj4KKyCgIKAgoCBpZiAocmVn
aXN0ZXJlZCAhPSAwKTxicj4KKyCgIKAgoCCgIKAgoCCgIHJldHVybjs8YnI+Cis8YnI+CisgoCCg
IKAgcGFyZW50ID0gdWRldl9kZXZpY2VfZ2V0X3BhcmVudCh1ZGV2X2RldmljZSk7PGJyPgorIKAg
oCCgIGludGZudW0gPSB1ZGV2X2RldmljZV9nZXRfc3lzYXR0cl92YWx1ZShwYXJlbnQsICZxdW90
O2JJbnRlcmZhY2VOdW1iZXImcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCBEQkcoJnF1b3Q7aW50
Zm51bSAlcyZxdW90OywgaW50Zm51bSk7PGJyPgorPGJyPgorIKAgoCCgIGlmIChnX3N0cmNtcDAo
aW50Zm51bSwgJnF1b3Q7MDEmcXVvdDspID09IDApIHs8YnI+CisgoCCgIKAgoCCgIKAgoCBkZXZu
b2RlID0gdWRldl9kZXZpY2VfZ2V0X2Rldm5vZGUodWRldl9kZXZpY2UpOzxicj4KKyCgIKAgoCCg
IKAgoCCgIG9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0sICZxdW90O01vZGVtJnF1b3Q7LCBk
ZXZub2RlKTs8YnI+CisgoCCgIKAgfSBlbHNlIGlmIChnX3N0cmNtcDAoaW50Zm51bSwgJnF1b3Q7
MDMmcXVvdDspID09IDApIHs8YnI+CisgoCCgIKAgoCCgIKAgoCBkZXZub2RlID0gdWRldl9kZXZp
Y2VfZ2V0X2Rldm5vZGUodWRldl9kZXZpY2UpOzxicj4KKyCgIKAgoCCgIKAgoCCgIG9mb25vX21v
ZGVtX3NldF9zdHJpbmcobW9kZW0sICZxdW90O0NvbnRyb2wmcXVvdDssIGRldm5vZGUpOzxicj4K
Kzxicj4KKyCgIKAgoCCgIKAgoCCgIG9mb25vX21vZGVtX3NldF9pbnRlZ2VyKG1vZGVtLCAmcXVv
dDtSZWdpc3RlcmVkJnF1b3Q7LCAxKTs8YnI+CisgoCCgIKAgoCCgIKAgoCBvZm9ub19tb2RlbV9y
ZWdpc3Rlcihtb2RlbSk7PGJyPgorIKAgoCCgIH08YnI+Cit9PGJyPgorPGJyPgqgc3RhdGljIHZv
aWQgYWRkX21vZGVtKHN0cnVjdCB1ZGV2X2RldmljZSAqdWRldl9kZXZpY2UpPGJyPgqgezxicj4K
IKAgoCCgIKBzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtOzxicj4KQEAgLTY0Niw2ICs2NzYsOCBA
QCBkb25lOjxicj4KIKAgoCCgIKAgoCCgIKAgoGFkZF90YzY1KG1vZGVtLCB1ZGV2X2RldmljZSk7
PGJyPgogoCCgIKAgoGVsc2UgaWYgKGdfc3RyY21wMChkcml2ZXIsICZxdW90O25va2lhY2RtYSZx
dW90OykgPT0gMCk8YnI+CiCgIKAgoCCgIKAgoCCgIKBhZGRfbm9raWFjZG1hKG1vZGVtLCB1ZGV2
X2RldmljZSk7PGJyPgorIKAgoCCgIKBlbHNlIGlmIChnX3N0cmNtcDAoZHJpdmVyLCAmcXVvdDts
aW5rdG9wJnF1b3Q7KSA9PSAwKTxicj4KKyCgIKAgoCCgIKAgoCCgIGFkZF9saW5rdG9wKG1vZGVt
LCB1ZGV2X2RldmljZSk7PGJyPgqgfTxicj4KPGJyPgqgc3RhdGljIGdib29sZWFuIGRldnBhdGhf
cmVtb3ZlKGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsIGdwb2ludGVyIHVzZXJfZGF0YSk8
YnI+Cjxmb250IGNvbG9yPSIjODg4ODg4Ij4tLTxicj4KMS43LjE8YnI+Cjxicj4KPC9mb250Pjwv
YmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9kaXY+Cg==

--===============6386211772098293224==--

