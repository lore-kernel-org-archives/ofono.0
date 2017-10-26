Content-Type: multipart/mixed; boundary="===============4171768929145992999=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: [PATCH] qmi: remove request when it timeouts
Date: Thu, 26 Oct 2017 17:36:48 +0200
Message-ID: <cf5ef8d7-9fd8-58ee-f297-158b764e1e64@kerlink.fr>
In-Reply-To: <13d9a774-2150-71e1-08e2-ee88556a2ca8@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4171768929145992999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,



On 10/26/2017 03:04 PM, Jonas Bonn wrote:
> Hi Christophe,
>
> Just a few trivial fixups below.
>
> On 10/26/2017 02:44 PM, Christophe Ronco wrote:
>> When modem does not answer or answers slowly to a discovery request,
>> a timeout occurs.
>> In timeout callback, request should be removed from queues to avoid
>> treating answer if it arrives later.
>> ---
>> =C2=A0 drivers/qmimodem/qmi.c | 26 ++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
>> index c538cb9..65263d2 100644
>> --- a/drivers/qmimodem/qmi.c
>> +++ b/drivers/qmimodem/qmi.c
>> @@ -1073,6 +1073,7 @@ struct discover_data {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qmi_discover_func_t func;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *user_data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qmi_destroy_func_t destroy;
>> +=C2=A0=C2=A0=C2=A0 uint8_t tid;
>
> This should be uint16_t.
tid field is set from transaction field in struct qmi_control_hdr. =

transaction is a uint8_t, why do you want tid to be uint16_t?
To avoid cast in discover_reply?
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guint timeout;
>> =C2=A0 };
>> =C2=A0 @@ -1181,14 +1182,38 @@ static gboolean discover_reply(gpointer =

>> user_data)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct discover_data *data =3D user_data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct qmi_device *device =3D data->devic=
e;
>> +=C2=A0=C2=A0=C2=A0 unsigned int tid =3D (unsigned int)(data->tid);
> You don't need the explicit cast here.
>
>> +=C2=A0=C2=A0=C2=A0 GList *list;
>> +=C2=A0=C2=A0=C2=A0 struct qmi_request *req =3D NULL;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->timeout =3D 0;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /* remove request from queues */
>> +=C2=A0=C2=A0=C2=A0 if (tid !=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list =3D g_queue_find_custom=
(device->req_queue,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 GUINT_TO_POINTER(tid), __request_compare);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req =
=3D list->data;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_qu=
eue_delete_link(device->req_queue, list);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list=
 =3D g_queue_find_custom(device->control_queue,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 GUINT_TO_POINTER(tid), __request_compare);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
list) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 req =3D list->data;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 g_queue_delete_link(device->control_queue,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->func)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->func(device=
->version_count,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device->version_list, data->user_data);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __qmi_device_discovery_complete(da=
ta->device, &data->super);
>> +=C2=A0=C2=A0=C2=A0 __request_free(req, NULL);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> =C2=A0 }
>> @@ -1234,6 +1259,7 @@ bool qmi_device_discover(struct qmi_device =

>> *device, qmi_discover_func_t func,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr->type =3D 0x00;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr->transaction =3D device->next_control=
_tid++;
>> +=C2=A0=C2=A0=C2=A0 data->tid =3D hdr->transaction;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __request_submit(device, req, hdr-=
>transaction);
>
> /Jonas
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

Christophe


--===============4171768929145992999==--

