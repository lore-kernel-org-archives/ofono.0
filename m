Content-Type: multipart/mixed; boundary="===============8421329316452061831=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: [PATCH qmi 4/5] gobi: take LLP-matching code from qmimodem
Date: Tue, 28 Mar 2017 15:38:08 +0200
Message-ID: <62b00020-560e-f939-1960-8eb9cf462d47@kerlink.fr>
In-Reply-To: <a283629a-21d9-0938-e33d-6f2b9320e459@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8421329316452061831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Jonas, hello Denis,

On 03/25/2017 10:11 PM, Denis Kenzior wrote:
> Hi Jonas,
>
> On 03/25/2017 11:57 AM, Jonas Bonn wrote:
>> The gobi plugin is a top-level construct that steers the creation
>> of other constructs based on modem capabilities.  The existence of
>> the WDA QMI service should thus be used to decide whether to attempt
>> to set the link-layer protocol based on the device configuration;
>> this code therefore belongs in the gobi plugin instead of in the
>> gprs-context code which is otherwise agnostic of any link-layer
>> settings.
>>
>> This patch, therefore, moves the code for querying the WDA service
>> and setting the link-layer protocol into the gobi driver.  The only
>> small change made with respect the original is a de-coupling of
>> service creation and setting of the link layer.
>
> Christophe added this recently, so he might want to comment...
First, I tried this patch on my MC7430 modem and it is still working.

I really don't know if this code should be in QMI driver or in Gobi =

plugin. It can be used by all QMI devices, that's why I put it in the =

driver but if Gobi plugin is the only entry point for QMI devices, =

that's also a great place for this code.

Creating service during enable is the best place to do it. I would have =

done service creation sequentially, not WDA and DMS at the same time but =

I assume it won't change anything and WDA service creation will always =

be shorter than DMS service creation and all the commands sent after.

As Denis proposed, I would have done the change of LLP inside the =

set_online callback rather than in gobi_post_online to be sure this is =

finished before the gprs_context is created (and maybe activated).

Best Regards,

Christophe

>
>> ---
>>  drivers/qmimodem/gprs-context.c | 74 =

>> +----------------------------------------
>>  plugins/gobi.c                  | 72 =

>> +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 73 insertions(+), 73 deletions(-)
>>
>> diff --git a/drivers/qmimodem/gprs-context.c =

>> b/drivers/qmimodem/gprs-context.c
>> index da2be24..ab9f005 100644
>> --- a/drivers/qmimodem/gprs-context.c
>> +++ b/drivers/qmimodem/gprs-context.c
>> @@ -30,15 +30,12 @@
>>  #include <ofono/gprs-context.h>
>>
>>  #include "qmi.h"
>> -#include "wda.h"
>>  #include "wds.h"
>>
>>  #include "qmimodem.h"
>>
>>  struct gprs_context_data {
>>      struct qmi_service *wds;
>> -    struct qmi_service *wda;
>> -    struct qmi_device *dev;
>>      unsigned int active_context;
>>      uint32_t pkt_handle;
>>  };
>> @@ -290,69 +287,6 @@ static void create_wds_cb(struct qmi_service =

>> *service, void *user_data)
>>                      pkt_status_notify, gc, NULL);
>>  }
>>
>> -static void get_data_format_cb(struct qmi_result *result, void =

>> *user_data)
>> -{
>> -    struct ofono_gprs_context *gc =3D user_data;
>> -    struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
>> -    uint32_t llproto;
>> -    enum qmi_device_expected_data_format expected_llproto;
>> -
>> -    DBG("");
>> -
>> -    if (qmi_result_set_error(result, NULL))
>> -        goto done;
>> -
>> -    if (!qmi_result_get_uint32(result, QMI_WDA_LL_PROTOCOL, &llproto))
>> -        goto done;
>> -
>> -    expected_llproto =3D qmi_device_get_expected_data_format(data->dev);
>> -
>> -    if ((llproto =3D=3D QMI_WDA_DATA_LINK_PROTOCOL_802_3) &&
>> -            (expected_llproto =3D=3D
>> -                QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP)) {
>> -        if (!qmi_device_set_expected_data_format(data->dev,
>> -                    QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3))
>> -            DBG("Fail to set expected data to 802.3");
>> -        else
>> -            DBG("expected data set to 802.3");
>> -    } else if ((llproto =3D=3D QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP) &&
>> -            (expected_llproto =3D=3D
>> -                QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3)) {
>> -        if (!qmi_device_set_expected_data_format(data->dev,
>> -                    QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP))
>> -            DBG("Fail to set expected data to raw-ip");
>> -        else
>> -            DBG("expected data set to raw-ip");
>> -    }
>> -
>> -done:
>> -    qmi_service_create(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
>> -                                    NULL);
>> -}
>> -
>> -static void create_wda_cb(struct qmi_service *service, void *user_data)
>> -{
>> -    struct ofono_gprs_context *gc =3D user_data;
>> -    struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
>> -
>> -    DBG("");
>> -
>> -    if (!service) {
>> -        DBG("Failed to request WDA service, continue initialization");
>> -        goto error;
>> -    }
>> -
>> -    data->wda =3D qmi_service_ref(service);
>> -
>> -    if (qmi_service_send(data->wda, QMI_WDA_GET_DATA_FORMAT, NULL,
>> -                    get_data_format_cb, gc, NULL) > 0)
>> -        return;
>> -
>> -error:
>> -    qmi_service_create(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
>> -                                    NULL);
>> -}
>> -
>>  static int qmi_gprs_context_probe(struct ofono_gprs_context *gc,
>>                      unsigned int vendor, void *user_data)
>>  {
>> @@ -364,9 +298,8 @@ static int qmi_gprs_context_probe(struct =

>> ofono_gprs_context *gc,
>>      data =3D g_new0(struct gprs_context_data, 1);
>>
>>      ofono_gprs_context_set_data(gc, data);
>> -    data->dev =3D device;
>>
>> -    qmi_service_create(device, QMI_SERVICE_WDA, create_wda_cb, gc, =

>> NULL);
>> +    qmi_service_create(device, QMI_SERVICE_WDS, create_wds_cb, gc, =

>> NULL);
>>
>>      return 0;
>>  }
>> @@ -384,11 +317,6 @@ static void qmi_gprs_context_remove(struct =

>> ofono_gprs_context *gc)
>>          qmi_service_unref(data->wds);
>>      }
>>
>> -    if (data->wda) {
>> -        qmi_service_unregister_all(data->wda);
>> -        qmi_service_unref(data->wda);
>> -    }
>> -
>>      g_free(data);
>>  }
>>
>> diff --git a/plugins/gobi.c b/plugins/gobi.c
>> index df35f94..d160d58 100644
>> --- a/plugins/gobi.c
>> +++ b/plugins/gobi.c
>> @@ -66,6 +66,7 @@
>>  struct gobi_data {
>>      struct qmi_device *device;
>>      struct qmi_service *dms;
>> +    struct qmi_service *wda;
>>      unsigned long features;
>>      unsigned int discover_attempts;
>>      uint8_t oper_mode;
>> @@ -252,6 +253,21 @@ error:
>>      shutdown_device(modem);
>>  }
>>
>> +static void create_wda_cb(struct qmi_service *service, void *user_data)
>> +{
>> +    struct ofono_modem *modem =3D user_data;
>> +    struct gobi_data *data =3D ofono_modem_get_data(modem);
>> +
>> +    DBG("");
>> +
>> +    if (!service) {
>> +        DBG("Failed to request WDA service, continue initialization");
>> +        return;
>> +    }
>> +
>> +    data->wda =3D qmi_service_ref(service);
>> +}
>> +
>>  static void discover_cb(uint8_t count, const struct qmi_version *list,
>>                              void *user_data)
>>  {
>> @@ -313,6 +329,10 @@ static void discover_cb(uint8_t count, const =

>> struct qmi_version *list,
>>          return;
>>      }
>>
>> +    if (data->features & GOBI_WDA)
>> +        qmi_service_create(data->device, QMI_SERVICE_WDA,
>> +                        create_wda_cb, modem, NULL);
>> +
>>      qmi_service_create_shared(data->device, QMI_SERVICE_DMS,
>>                          create_dms_cb, modem, NULL);
>>  }
>> @@ -368,6 +388,11 @@ static int gobi_disable(struct ofono_modem *modem)
>>      qmi_service_cancel_all(data->dms);
>>      qmi_service_unregister_all(data->dms);
>>
>> +    if (data->wda) {
>> +        qmi_service_unregister_all(data->wda);
>> +        qmi_service_unref(data->wda);
>> +    }
>> +
>>      /*
>>       * Telit QMI modem must remain online. If powered down, it also
>>       * powers down the sim card, and QMI interface has no way to bring
>> @@ -484,14 +509,61 @@ static void gobi_post_sim(struct ofono_modem =

>> *modem)
>>          ofono_sms_create(modem, 0, "qmimodem", data->device);
>>  }
>>
>> +static void get_data_format_cb(struct qmi_result *result, void =

>> *user_data)
>> +{
>> +    struct ofono_modem* modem =3D user_data;
>> +    struct gobi_data *data =3D ofono_modem_get_data(modem);
>> +    uint32_t llproto;
>> +    enum qmi_device_expected_data_format expected_llproto;
>> +
>> +    DBG("");
>> +
>> +    if (qmi_result_set_error(result, NULL))
>> +        return;
>> +
>> +    if (!qmi_result_get_uint32(result, QMI_WDA_LL_PROTOCOL, &llproto))
>> +        return;
>> +
>> +    expected_llproto =3D =

>> qmi_device_get_expected_data_format(data->device);
>> +
>> +    if ((llproto =3D=3D QMI_WDA_DATA_LINK_PROTOCOL_802_3) &&
>> +            (expected_llproto =3D=3D
>> +                QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP)) {
>> +        if (!qmi_device_set_expected_data_format(data->device,
>> +                    QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3))
>> +            DBG("Fail to set expected data to 802.3");
>> +        else
>> +            DBG("expected data set to 802.3");
>> +    } else if ((llproto =3D=3D QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP) &&
>> +            (expected_llproto =3D=3D
>> +                QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3)) {
>> +        if (!qmi_device_set_expected_data_format(data->device,
>> +                    QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP))
>> +            DBG("Fail to set expected data to raw-ip");
>> +        else
>> +            DBG("expected data set to raw-ip");
>> +    }
>> +}
>> +
>>  static void gobi_post_online(struct ofono_modem *modem)
>>  {
>>      struct gobi_data *data =3D ofono_modem_get_data(modem);
>>      struct ofono_gprs *gprs;
>>      struct ofono_gprs_context *gc;
>> +    int err;
>>
>>      DBG("%p", modem);
>>
>> +    if (data->features & GOBI_WDA) {
>> +        /* Query device link-layer protocol */
>> +        err =3D qmi_service_send(data->wda,
>> +                    QMI_WDA_GET_DATA_FORMAT, NULL,
>> +                    get_data_format_cb, modem, NULL);
>> +        if (err) {
>> +            DBG("Failed to query link layer protocol");
>> +        }
>
> Not our style, no need for {}
>
> Also, it is really frowned upon to call initialization functions from =

> inside pre_sim, post_sim and post_online.  They're really only for =

> atom creation.
>
> Is WDA_GET_DATA_FORMAT available right after we power the device on, =

> e.g. by using SET_OPER_MODE?
>
> Alternatively, this might need to be done as a part of the .set_online =

> transaction.
>
>> +    }
>> +
>>      if (data->features & GOBI_NAS)
>>          ofono_netreg_create(modem, 0, "qmimodem", data->device);
>>
>>
>
> Regards,
> -Denis
>


--===============8421329316452061831==--

